package rules_scala
package workers.zinc.compile

import com.google.devtools.build.buildjar.jarhelper.JarHelper
import java.io.{File, InputStream, OutputStream, OutputStreamWriter}
import java.nio.charset.StandardCharsets
import java.nio.file.{Files, NoSuchFileException, Path, Paths}
import java.nio.file.attribute.FileTime
import java.util.zip.{GZIPInputStream, GZIPOutputStream}
import java.util.{Optional, Map as JMap}
import scala.jdk.CollectionConverters.*
import sbt.internal.shaded.com.google.protobuf.{GeneratedMessageV3, Parser}
import sbt.internal.inc.binary.converters.{ProtobufReaders, ProtobufWriters}
import sbt.internal.inc.text.Mapper
import sbt.internal.inc.{APIs, Analysis, Relations, SourceInfos, Stamper, Stamps, Schema, Stamp as StampImpl, PlainVirtualFile}
import xsbti.compile.analysis.{GenericMapper, ReadMapper, ReadWriteMappers, Stamp, WriteMapper}
import xsbti.compile.{AnalysisContents, AnalysisStore, MiniSetup}
import xsbti.{PathBasedFile, VirtualFileRef}

final case class AnalysisFiles(apis: Path, miniSetup: Path, relations: Path, sourceInfos: Path, stamps: Path)

object AnxAnalysisStore:
  trait Format:
    def read[A <: GeneratedMessageV3](parser: Parser[A], inputStream: InputStream): A
    def write(message: GeneratedMessageV3, stream: OutputStream): Unit

  object BinaryFormat extends Format:
    def read[A <: GeneratedMessageV3](parser: Parser[A], stream: InputStream) =
      parser.parseFrom(new GZIPInputStream(stream))
    def write(message: GeneratedMessageV3, stream: OutputStream): Unit =
      val gzip = new GZIPOutputStream(stream, true)
      message.writeTo(gzip)
      gzip.finish()

  object TextFormat extends Format:
    def read[A <: GeneratedMessageV3](parser: Parser[A], stream: InputStream) =
      parser.parseFrom(stream)
    def write(message: GeneratedMessageV3, stream: OutputStream): Unit =
      val writer = new OutputStreamWriter(stream, StandardCharsets.US_ASCII)
      try writer.write(message.toString)
      finally writer.close()

trait Readable[A]:
  def read(file: Path): A

trait Writeable[A]:
  def write(file: Path, value: A): Unit

final class Store[A](readStream: InputStream => A, writeStream: (OutputStream, A) => Unit) extends Readable[A] with Writeable[A]:
  def read(file: Path): A =
    val stream = Files.newInputStream(file)
    try readStream(stream)
    finally stream.close()
  def write(file: Path, value: A): Unit =
    val stream = Files.newOutputStream(file)
    try writeStream(stream, value)
    finally stream.close()

final class AnxAnalysisStore(files: AnalysisFiles, analyses: AnxAnalyses) extends AnalysisStore:
  final val Empty = Optional.empty[AnalysisContents]

  override def get: Optional[AnalysisContents] =
    try
      val analysis = Analysis.Empty.copy(
        apis = analyses.apis.read(files.apis),
        relations = analyses.relations.read(files.relations),
        infos = analyses.sourceInfos.read(files.sourceInfos),
        stamps = analyses.stamps.read(files.stamps)
      )
      val miniSetup = analyses.miniSetup.read(files.miniSetup)
      Optional.of(AnalysisContents.create(analysis, miniSetup))
    catch
      case e: NoSuchFileException => Empty

  override def unsafeGet: AnalysisContents = get.get

  override def set(analysisContents: AnalysisContents): Unit =
    val analysis = analysisContents.getAnalysis.asInstanceOf[Analysis]
    analyses.apis.write(files.apis, analysis.apis)
    analyses.relations.write(files.relations, analysis.relations)
    analyses.sourceInfos.write(files.sourceInfos, analysis.infos)
    analyses.stamps.write(files.stamps, analysis.stamps)
    val miniSetup = analysisContents.getMiniSetup
    analyses.miniSetup.write(files.miniSetup, miniSetup)

final class AnxAnalyses(format: AnxAnalysisStore.Format):
  private val mappers = AnxMapper.mappers(Paths.get(""))
  private val reader = new ProtobufReaders(mappers.getReadMapper, Schema.Version.V1_1)
  private val writer = new ProtobufWriters(mappers.getWriteMapper)

  def apis =
    new Store[APIs](
      stream => reader.fromApis(shouldStoreApis = true)(format.read[Schema.APIs](Schema.APIs.parser, stream)),
      (stream, value) => format.write(update(writer.toApis(value, shouldStoreApis = true)), stream)
    )

  def miniSetup =
    new Store[MiniSetup](
      stream => reader.fromMiniSetup(format.read[Schema.MiniSetup](Schema.MiniSetup.parser, stream)),
      (stream, value) => format.write(writer.toMiniSetup(value), stream)
    )

  def relations =
    new Store[Relations](
      stream => reader.fromRelations(update(mappers.getReadMapper, format.read[Schema.Relations](Schema.Relations.parser, stream))),
      (stream, value) => format.write(update(mappers.getWriteMapper, writer.toRelations(value)), stream)
    )

  def sourceInfos =
    new Store[SourceInfos](
      stream => reader.fromSourceInfos(format.read[Schema.SourceInfos](Schema.SourceInfos.parser, stream)),
      (stream, value) => format.write(writer.toSourceInfos(value), stream)
    )

  def stamps =
    new Store[Stamps](
      stream => reader.fromStamps(format.read[Schema.Stamps](Schema.Stamps.parser, stream)),
      (stream, value) => format.write(writer.toStamps(value), stream)
    )

  private def updateAnalyzedMap(map: JMap[String, Schema.AnalyzedClass]): JMap[String, Schema.AnalyzedClass] =
    map.asScala.map {
      case (key, cls) => key -> cls.toBuilder().setCompilationTimestamp(JarHelper.DEFAULT_TIMESTAMP).build()
    }.asJava

  private def update(api: Schema.APIs): Schema.APIs =
    api
      .toBuilder()
      .putAllInternal(updateAnalyzedMap(api.getInternalMap))
      .putAllExternal(updateAnalyzedMap(api.getExternalMap))
      .build()

  // Workaround for https://github.com/sbt/zinc/pull/532
  private def update(
      mapper: GenericMapper,
      relations: Schema.Relations
  ): Schema.Relations =
    val updatedSrcProd = relations.getSrcProdMap.asScala.map {
      case (source, products) =>
        val values = products.getValuesList().asScala.map(path => mapper.mapProductFile(Mapper.forFileV.read(path)).toString)
        mapper.mapSourceFile(Mapper.forFileV.read(source)).toString -> Schema.Values.newBuilder().addAllValues(values.asJava).build()
    }
    val updatedLibraryDep = relations.getLibraryDepMap.asScala.map {
      case (source, binaries) =>
        val values = binaries.getValuesList().asScala.map(path => mapper.mapBinaryFile(Mapper.forFileV.read(path)).toString)
        mapper
          .mapBinaryFile(mapper.mapSourceFile(Mapper.forFileV.read(source)))
          .toString -> Schema.Values.newBuilder().addAllValues(values.asJava).build()
    }
    val updatedClasses = relations.getClassesMap.asScala.map {
      case (source, values) =>
        mapper.mapSourceFile(Mapper.forFileV.read(source)).toString -> values
    }
    relations.toBuilder().putAllSrcProd(updatedSrcProd.asJava).putAllLibraryDep(updatedLibraryDep.asJava).putAllClasses(updatedClasses.asJava).build()

object AnxMapper:
  val rootPlaceholder = Paths.get("_ROOT_")

  def mappers(root: Path) = new ReadWriteMappers(new AnxReadMapper(root), new AnxWriteMapper(root))

  def hashStamp(file: Path): Stamp =
    val newTime = Files.getLastModifiedTime(file)
    stampCache.get(file) match
      case Some((time, stamp)) if newTime.compareTo(time) <= 0 => stamp
      case _ =>
        val stamp = Stamper.forFarmHashP(file)
        stampCache += (file -> (newTime, stamp))
        stamp

  private val stampCache = new scala.collection.mutable.HashMap[Path, (FileTime, Stamp)]

final class AnxWriteMapper(root: Path) extends WriteMapper:
  private val rootAbs = root.toAbsolutePath

  private def mapFile(file: Path): Path =
    if file.startsWith(rootAbs) then AnxMapper.rootPlaceholder.resolve(rootAbs.relativize(file))
    else file

  private def mapFile(file: VirtualFileRef): VirtualFileRef =
    file match
      case file: PathBasedFile => PlainVirtualFile(mapFile(file.toPath))
      case _                   => file

  override def mapSourceFile(sourceFile: VirtualFileRef): VirtualFileRef = mapFile(sourceFile)
  override def mapBinaryFile(binaryFile: VirtualFileRef): VirtualFileRef = mapFile(binaryFile)
  override def mapProductFile(productFile: VirtualFileRef): VirtualFileRef = mapFile(productFile)

  override def mapClasspathEntry(classpathEntry: Path): Path = mapFile(classpathEntry)
  override def mapJavacOption(javacOption: String): String = javacOption
  override def mapScalacOption(scalacOption: String): String = scalacOption

  override def mapOutputDir(outputDir: Path): Path = mapFile(outputDir)
  override def mapSourceDir(sourceDir: Path): Path = mapFile(sourceDir)

  override def mapProductStamp(file: VirtualFileRef, productStamp: Stamp) =
    StampImpl.fromString(s"lastModified(${JarHelper.DEFAULT_TIMESTAMP})")
  override def mapSourceStamp(file: VirtualFileRef, sourceStamp: Stamp): Stamp = sourceStamp
  override def mapBinaryStamp(file: VirtualFileRef, binaryStamp: Stamp) = binaryStamp

  override def mapMiniSetup(miniSetup: MiniSetup): MiniSetup = miniSetup

final class AnxReadMapper(root: Path) extends ReadMapper:
  private val rootAbs = root.toAbsolutePath

  private def mapFile(file: Path): Path =
    if file.startsWith(AnxMapper.rootPlaceholder) then
      rootAbs.resolve(AnxMapper.rootPlaceholder.relativize(file))
    else file

  private def mapFile(file: VirtualFileRef): VirtualFileRef =
    file match
      case file: PathBasedFile => PlainVirtualFile(mapFile(file.toPath))
      case _                   => file

  override def mapSourceFile(sourceFile: VirtualFileRef): VirtualFileRef = mapFile(sourceFile)
  override def mapBinaryFile(binaryFile: VirtualFileRef): VirtualFileRef = mapFile(binaryFile)
  override def mapProductFile(productFile: VirtualFileRef): VirtualFileRef = mapFile(productFile)

  override def mapClasspathEntry(classpathEntry: Path): Path = mapFile(classpathEntry)
  override def mapJavacOption(javacOption: String): String = javacOption
  override def mapScalacOption(scalacOption: String): String = scalacOption

  override def mapOutputDir(outputDir: Path): Path = mapFile(outputDir)
  override def mapSourceDir(sourceDir: Path): Path = mapFile(sourceDir)

  override def mapProductStamp(file: VirtualFileRef, productStamp: Stamp): Stamp =
    file match
      case file: PathBasedFile => Stamper.forLastModifiedP(file.toPath())
      case _                   => productStamp
  override def mapSourceStamp(file: VirtualFileRef, sourceStamp: Stamp): Stamp = sourceStamp
  override def mapBinaryStamp(file: VirtualFileRef, binaryStamp: Stamp): Stamp =
    file match
      case file: PathBasedFile =>
        val filePath = file.toPath()
        if AnxMapper.hashStamp(filePath) == binaryStamp then Stamper.forLastModifiedP(filePath)
        else binaryStamp
      case _ => binaryStamp

  override def mapMiniSetup(miniSetup: MiniSetup): MiniSetup = miniSetup
