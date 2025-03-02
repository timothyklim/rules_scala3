package rules_scala
package workers.zinc.compile

import java.io.{File, InputStream, OutputStream, OutputStreamWriter}
import java.nio.charset.StandardCharsets
import java.nio.file.{Files, NoSuchFileException, Path, Paths}
import java.nio.file.attribute.FileTime
import java.util.{Map as JMap, Optional}
import java.util.zip.{GZIPInputStream, GZIPOutputStream}

import scala.collection.mutable
import scala.jdk.CollectionConverters.*

import com.google.devtools.build.buildjar.jarhelper.JarHelper
import sbt.internal.inc.{APIs, Analysis, PlainVirtualFile, Relations, SourceInfos, Stamp as StampImpl, Stamper, Stamps}
import sbt.internal.inc.text.Mapper
import sbt.internal.inc.consistent.ConsistentFileAnalysisStore
import xsbti.{PathBasedFile, VirtualFileRef}
import xsbti.compile.{AnalysisContents, AnalysisStore, MiniSetup}
import xsbti.compile.analysis.{GenericMapper, ReadMapper, ReadWriteMappers, Stamp, WriteMapper}
import workers.common.AnnexLogger

final class AnxAnalysisStore(analysisStoreFile: File, format: AnxAnalysisStore.Format)(using ZincContext, AnnexLogger) extends AnalysisStore:
  private val store = format.store(analysisStoreFile)

  override def set(contents: AnalysisContents): Unit = store.set(contents)
  override def get: Optional[AnalysisContents] = store.get
  override def unsafeGet: AnalysisContents = get.get

object AnxAnalysisStore:
  sealed trait Format:
    final def store(analysisStoreFile: File)(using ZincContext, AnnexLogger): AnalysisStore =
      store(analysisStoreFile, AnxMapper.mappers())

    final def store(analysisStoreFile: File, mappers: ReadWriteMappers): AnalysisStore = this match
      case BinaryFormat =>
        ConsistentFileAnalysisStore.binary(
          analysisStoreFile,
          mappers,
          reproducible = true,
          parallelism = math.min(Runtime.getRuntime.availableProcessors(), 8)
        )
      case TextFormat => ConsistentFileAnalysisStore.text(analysisStoreFile, mappers, reproducible = true, parallelism = 1)

    final def read(analysisStoreFile: File, mappers: ReadWriteMappers): Analysis =
      store(analysisStoreFile, mappers).unsafeGet().getAnalysis.asInstanceOf[Analysis]

    final def read(analysisStoreFile: File)(using ZincContext, AnnexLogger): Analysis =
      read(analysisStoreFile, AnxMapper.mappers())

  case object TextFormat extends Format
  case object BinaryFormat extends Format

object AnxMapper:
  val RootPlaceholder = Paths.get("_ROOT_")
  val TmpPlaceholder = Paths.get("_TMP_")

  def mappers()(using ctx: ZincContext, logger: AnnexLogger) = ReadWriteMappers(AnxReadMapper(), AnxWriteMapper())

  def hashStamp(file: Path): Stamp =
    val newTime = Files.getLastModifiedTime(file)
    stampCache.get(file) match
      case Some((time, stamp)) if newTime.compareTo(time) <= 0 => stamp
      case _ =>
        val stamp = Stamper.forFarmHashP(file)
        stampCache += (file -> (newTime, stamp))
        stamp

  private val stampCache = mutable.HashMap.empty[Path, (FileTime, Stamp)]

final class AnxWriteMapper()(using ctx: ZincContext) extends WriteMapper:
  private def mapFile(file: Path): Path =
    val absolutePath = if file.isAbsolute() then file else file.toAbsolutePath()
    if absolutePath.startsWith(ctx.tmpDir) then AnxMapper.TmpPlaceholder.resolve(ctx.tmpDir.relativize(absolutePath))
    else if absolutePath.startsWith(ctx.rootDir) then AnxMapper.RootPlaceholder.resolve(ctx.rootDir.relativize(absolutePath))
    else absolutePath

  private def mapFile(file: VirtualFileRef): VirtualFileRef =
    val path = file match
      case file: PathBasedFile => file.toPath
      case _                   => Paths.get(file.toString)
    PlainVirtualFile(mapFile(path))

  override def mapSourceFile(sourceFile: VirtualFileRef): VirtualFileRef = mapFile(sourceFile)
  override def mapBinaryFile(binaryFile: VirtualFileRef): VirtualFileRef = mapFile(binaryFile)
  override def mapProductFile(productFile: VirtualFileRef): VirtualFileRef = mapFile(productFile)

  override def mapClasspathEntry(classpathEntry: Path): Path = mapFile(classpathEntry)
  override def mapJavacOption(javacOption: String): String = javacOption
  override def mapScalacOption(scalacOption: String): String = scalacOption

  override def mapOutputDir(outputDir: Path): Path = mapFile(outputDir)
  override def mapSourceDir(sourceDir: Path): Path = mapFile(sourceDir)

  override def mapProductStamp(file: VirtualFileRef, productStamp: Stamp): Stamp = productStamp
  // StampImpl.fromString(s"lastModified(${JarHelper.DEFAULT_TIMESTAMP})")
  override def mapSourceStamp(file: VirtualFileRef, sourceStamp: Stamp): Stamp = sourceStamp
  override def mapBinaryStamp(file: VirtualFileRef, binaryStamp: Stamp): Stamp = binaryStamp

  override def mapMiniSetup(miniSetup: MiniSetup): MiniSetup = miniSetup

final class AnxReadMapper()(using ctx: ZincContext, logger: AnnexLogger) extends ReadMapper:
  private def mapFile(file: Path): Path =
    val path =
      if file.startsWith(AnxMapper.TmpPlaceholder) then ctx.tmpDir.resolve(AnxMapper.TmpPlaceholder.relativize(file))
      else if file.startsWith(AnxMapper.RootPlaceholder) then ctx.rootDir.resolve(AnxMapper.RootPlaceholder.relativize(file))
      else file
    if !path.toFile().exists() then logger.debug(() => s"File `$path` not found")
    path

  private def mapFile(file: VirtualFileRef): VirtualFileRef =
    val path = file match
      case file: PathBasedFile => file.toPath
      case _                   => Paths.get(file.toString)
    PlainVirtualFile(mapFile(path))

  override def mapSourceFile(sourceFile: VirtualFileRef): VirtualFileRef = mapFile(sourceFile)
  override def mapBinaryFile(binaryFile: VirtualFileRef): VirtualFileRef = mapFile(binaryFile)
  override def mapProductFile(productFile: VirtualFileRef): VirtualFileRef = mapFile(productFile)

  override def mapClasspathEntry(classpathEntry: Path): Path = mapFile(classpathEntry)
  override def mapJavacOption(javacOption: String): String = javacOption
  override def mapScalacOption(scalacOption: String): String = scalacOption

  override def mapOutputDir(outputDir: Path): Path = mapFile(outputDir)
  override def mapSourceDir(sourceDir: Path): Path = mapFile(sourceDir)

  override def mapProductStamp(file: VirtualFileRef, productStamp: Stamp): Stamp = productStamp
  // file match
  //   case file: PathBasedFile => Stamper.forLastModifiedP(file.toPath())
  //   case _                   => productStamp
  override def mapSourceStamp(file: VirtualFileRef, sourceStamp: Stamp): Stamp = sourceStamp
  override def mapBinaryStamp(file: VirtualFileRef, binaryStamp: Stamp): Stamp = binaryStamp
  // val res = file match
  //   case file: PathBasedFile =>
  //     val filePath = file.toPath()
  //     if AnxMapper.hashStamp(filePath) == binaryStamp then Stamper.forLastModifiedP(filePath)
  //     else binaryStamp
  //   case _ => binaryStamp
  // println(s"mapBinaryStamp file:$file binaryStamp:$binaryStamp res:$res")
  // res

  override def mapMiniSetup(miniSetup: MiniSetup): MiniSetup = miniSetup
