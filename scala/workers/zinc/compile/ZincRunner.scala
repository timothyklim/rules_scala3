package rules_scala
package workers.zinc.compile


import java.io.{File, PrintWriter}
import java.net.URLClassLoader
import java.nio.file.{Files, NoSuchFileException, Path, Paths}
import java.text.SimpleDateFormat
import java.util.{Date, Optional, Properties, List as JList}

import scala.jdk.CollectionConverters.*
import scala.util.Try
import scala.util.control.NonFatal

import com.google.devtools.build.buildjar.jarhelper.JarCreator
import sbt.internal.inc.{Analysis, CompileFailed, IncrementalCompilerImpl, Locate, PlainVirtualFile, ZincUtil}
import sbt.internal.inc.classpath.ClassLoaderCache
import scopt.OParser
import xsbti.{Logger, PathBasedFile, VirtualFile}
import xsbti.compile.{
  AnalysisContents,
  ClasspathOptionsUtil,
  CompileAnalysis,
  CompileOptions,
  CompileProgress,
  CompilerCache,
  DefinesClass,
  IncOptions,
  Inputs,
  MiniSetup,
  PerClasspathEntryLookup,
  PreviousResult,
  Setup
}

import rules_scala.common.worker.WorkerMain
import rules_scala.workers.common.*

final case class ZincRunnerArguments(
  usePersistence: Boolean = true,
  depsCache: Option[Path] = None,
  persistenceDir: Option[Path] = None,
)
object ZincRunnerArguments:
  private val builder = OParser.builder[ZincRunnerArguments]
  import builder.*

  private val parser = OParser.sequence(
    opt[Boolean]("use_persistence").action((p, c) => c.copy(usePersistence = p)),
    opt[String]("extracted_file_cache").optional().action((p, c) => c.copy(depsCache = Some(pathFrom(p)))),
    opt[String]("persistence_dir").optional().action((p, c) => c.copy(persistenceDir = Some(pathFrom(p)))),
  )

  def apply(args: collection.Seq[String]): Option[ZincRunnerArguments] =
    OParser.parse(parser, args, ZincRunnerArguments())

  private def pathFrom(path: String): Path = Paths.get(path.replace("~", sys.props.getOrElse("user.home", "")))

final case class AnalysisArgument(label: String, apis: Path, relations: Path, jars: Vector[Path])
object AnalysisArgument:
  def from(value: String): AnalysisArgument = value.split(',') match
    case Array(prefixedLabel, apis, relations, jars @ _*) =>
      AnalysisArgument(prefixedLabel.stripPrefix("_"), Paths.get(apis), Paths.get(relations), jars.map(Paths.get(_)).toVector)

final case class ZincWorkArguments(
  analysis: Vector[AnalysisArgument] = Vector.empty,
  classpath: Vector[Path] = Vector.empty,
  compilerBridge: File = new File("."),
  compilerClasspath: Vector[File] = Vector.empty,
  compilerOption: Vector[String] = Vector.empty,
  debug: Boolean = false,
  javaCompilerOption: Vector[String] = Vector.empty,
  label: String = "",
  logLevel: LogLevel = LogLevel.Warn,
  mainManifest: File = new File("."),
  outputApis: Path = Paths.get("."),
  outputInfos: Path = Paths.get("."),
  outputJar: Path = Paths.get("."),
  outputRelations: Path = Paths.get("."),
  outputSetup: Path = Paths.get("."),
  outputStamps: Path = Paths.get("."),
  outputUsed: Path = Paths.get("."),
  plugins: Vector[File] = Vector.empty,
  sourceJars: Vector[Path] = Vector.empty,
  sources: Vector[File] = Vector.empty,
  tmpDir: Path = Paths.get("."),
) extends PrettyProduct
object ZincWorkArguments:
  private val builder = OParser.builder[ZincWorkArguments]
  import builder.*

  private val parser = OParser.sequence(
    opt[LogLevel]("log_level")
      .optional()
      .action((lvl, c) => c.copy(logLevel = lvl))
      .text("Log level"),
    opt[File]("source_jar")
      .unbounded()
      .optional()
      .action((s, c) => c.copy(sourceJars = c.sourceJars :+ s.toPath()))
      .text("Source jars"),
    opt[File]("tmp")
      .required()
      .action((tmp, c) => c.copy(tmpDir = tmp.toPath))
      .text("Temporary directory"),
    opt[File]("output_jar")
      .required()
      .action((jar, c) => c.copy(outputJar = jar.toPath))
      .text("Output jar"),
    opt[String]("analysis")
      .unbounded()
      .optional()
      .valueName("args")
      .action((arg, c) => c.copy(analysis = c.analysis :+ AnalysisArgument.from(arg)))
      .text("Analysis, given as: label apis relations [jar ...]"),
    opt[File]("cp")
      .unbounded()
      .optional()
      .action((cp, c) => c.copy(classpath = c.classpath :+ cp.toPath))
      .text("Compilation classpath"),
    opt[File]("compiler_cp")
      .unbounded()
      .optional()
      .action((cp, c) => c.copy(compilerClasspath = c.compilerClasspath :+ cp))
      .text("Compiler classpath"),
    opt[File]("output_apis")
      .required()
      .action((out, c) => c.copy(outputApis = out.toPath))
      .text("Output APIs"),
    opt[File]("output_setup")
      .required()
      .action((out, c) => c.copy(outputSetup = out.toPath))
      .text("Output Zinc setup"),
    opt[File]("output_relations")
      .required()
      .action((out, c) => c.copy(outputRelations = out.toPath))
      .text("Output Zinc relations"),
    opt[File]("output_infos")
      .required()
      .action((out, c) => c.copy(outputInfos = out.toPath))
      .text("Output Zinc source infos"),
    opt[File]("output_stamps")
      .required()
      .action((out, c) => c.copy(outputStamps = out.toPath))
      .text("Output Zinc source stamps"),
    opt[Boolean]("debug").action((debug, c) => c.copy(debug = debug)),
    opt[String]("label")
      .required()
      .action((l, c) => c.copy(label = l))
      .text("Bazel label"),
    opt[File]("compiler_bridge")
      .required()
      .action((bridge, c) => c.copy(compilerBridge = bridge))
      .text("Compiler bridge"),
    opt[File]("main_manifest")
      .required()
      .action((manifest, c) => c.copy(mainManifest = manifest))
      .text("List of main entry points"),
    opt[File]("output_used")
      .required()
      .action((out, c) => c.copy(outputUsed = out.toPath))
      .text("Output list of used jars"),
    opt[String]("compiler_option")
      .unbounded()
      .optional()
      .action((opt, c) => c.copy(compilerOption = c.compilerOption :+ opt))
      .text("Compiler option"),
    opt[String]("java_compiler_option")
      .unbounded()
      .optional()
      .action((opt, c) => c.copy(javaCompilerOption = c.javaCompilerOption :+ opt))
      .text("Java compiler option"),
    opt[File]("plugin")
      .unbounded()
      .optional()
      .action((p, c) => c.copy(plugins = c.plugins :+ p))
      .text("Compiler plugins"),
    arg[File]("<source>...")
      .unbounded()
      .optional()
      .action((s, c) => c.copy(sources = c.sources :+ s))
      .text("Source files"),
  )

  def apply(args: collection.Seq[String]): Option[ZincWorkArguments] =
    OParser.parse(parser, args, ZincWorkArguments())

/**
  * <strong>Caching</strong>
  *
  * Zinc has two caches:
  *  1. a ClassLoaderCache which is a soft reference cache for classloaders of Scala compilers.
  *  2. a CompilerCache which is a hard reference cache for (I think) Scala compiler instances.
  *
  * The CompilerCache has reproducibility issues, so it needs to be a no-op.
  * The ClassLoaderCache needs to be reused else JIT reuse (i.e. the point of the worker strategy) doesn't happen.
  *
  * There are two sensible strategies for Bazel workers
  *  A. Each worker compiles multiple Scala versions. Trust the ClassLoaderCache's timestamp check. Maintain a hard
  *     reference to the classloader for the last version, and allow previous versions to be GC'ed subject to
  *     free memory and -XX:SoftRefLRUPolicyMSPerMB.
  *  B. Each worker compiles a single Scala version. Probably still use ClassLoaderCache + hard reference since
  *     ClassLoaderCache is hard to remove. The compiler classpath is passed via the initial flags to the worker
  *     (rather than the per-request arg file). Bazel worker management cycles out Scala compiler versions.
  * Currently, this runner follows strategy A.
  */
object ZincRunner extends WorkerMain[ZincRunnerArguments]:
  private val topLoader = TopClassLoader(getClass().getClassLoader())
  private val classloaderCache = ClassLoaderCache(URLClassLoader(Array.empty))

  private val compilerCache = CompilerCache.fresh

  // prevents GC of the soft reference in classloaderCache
  private var lastCompiler: AnyRef = null

  private def labelToPath(label: String): Path =
    Paths.get(label.replaceAll("^/+", "").replaceAll(raw"[^\w/]", "_"))

  override def init(args: Option[Array[String]]) =
    val xs = args.getOrElse(Array.empty[String])
    ZincRunnerArguments(xs).getOrElse(throw IllegalArgumentException(s"init args is invalid: ${xs.mkString(" ")}"))

  override def work(workerArgs: ZincRunnerArguments, args: Array[String]) =
    val workArgs = ZincWorkArguments(args).getOrElse(throw IllegalArgumentException(s"work args is invalid: ${args.mkString(" ")}"))

    val logger = AnnexLogger(workArgs.logLevel)

    val sourcesDir = workArgs.tmpDir.resolve("src")
    // extract srcjars
    val sources: collection.Seq[File] = workArgs.sources ++ workArgs
      .sourceJars
      .zipWithIndex
      .flatMap((jar, i) => FileUtil.extractZip(jar, sourcesDir.resolve(i.toString)))
      .map(_.toFile)

    // extract upstream classes
    val classesDir = workArgs.tmpDir.resolve("classes")

    val analyses = workerArgs.usePersistence match
      case true =>
        workArgs
          .analysis
          .flatMap(arg => arg.jars.map(jar => jar -> (classesDir.resolve(labelToPath(arg.label)), DepAnalysisFiles(arg.apis, arg.relations))))
          .toMap
      case false => Map.empty
    val deps = Dep.create(workerArgs.depsCache, workArgs.classpath, analyses)

    // load persisted files
    val analysisFiles = AnalysisFiles(
      apis = workArgs.outputApis,
      miniSetup = workArgs.outputSetup,
      relations = workArgs.outputRelations,
      sourceInfos = workArgs.outputInfos,
      stamps = workArgs.outputStamps
    )
    val analysesFormat = AnxAnalyses(if (workArgs.debug) AnxAnalysisStore.TextFormat else AnxAnalysisStore.BinaryFormat)
    val analysisStore = AnxAnalysisStore(analysisFiles, analysesFormat)

    val persistence = workerArgs.persistenceDir.fold[ZincPersistence](NullPersistence) { rootDir =>
      val path = workArgs.label.replaceAll("^/+", "").replaceAll(raw"[^\w/]", "_")
      FilePersistence(rootDir.resolve(path), analysisFiles, workArgs.outputJar)
    }

    val classesOutputDir = classesDir.resolve(labelToPath(workArgs.label))
    try
      persistence.load()
      if (Files.exists(workArgs.outputJar))
        try FileUtil.extractZip(workArgs.outputJar, classesOutputDir)
        finally FileUtil.delete(classesOutputDir)
    catch case NonFatal(e) =>
      logger.warn(() => s"Failed to load cached analysis: $e")
      Files.delete(analysisFiles.apis)
      Files.delete(analysisFiles.miniSetup)
      Files.delete(analysisFiles.relations)
      Files.delete(analysisFiles.sourceInfos)
      Files.delete(analysisFiles.stamps)
    Files.createDirectories(classesOutputDir)

    val previousResult = Try(analysisStore.get())
      .fold(
        { e =>
          logger.warn(() => s"Failed to load previous analysis: $e")
          Optional.empty[AnalysisContents]()
        },
        identity
      )
      .map[PreviousResult](contents => PreviousResult.of(Optional.of(contents.getAnalysis), Optional.of(contents.getMiniSetup)))
      .orElseGet(() => PreviousResult.of(Optional.empty[CompileAnalysis](), Optional.empty[MiniSetup]()))

    // setup compiler
    val scalaInstance = AnnexScalaInstance(topLoader, classloaderCache, workArgs.compilerClasspath.toArray)

    val compileOptions = CompileOptions.create
      .withSources(sources.map(f => PlainVirtualFile(f.toPath())).toArray)
      .withClasspath((classesOutputDir +: deps.map(_.classpath)).map(PlainVirtualFile(_)).toArray)
      .withClassesDirectory(classesOutputDir)
      .withJavacOptions(workArgs.javaCompilerOption.toArray)
      .withScalacOptions((workArgs.plugins.map(p => s"-Xplugin:$p") ++ workArgs.compilerOption).toArray)

    val scalaCompiler = ZincUtil
      .scalaCompiler(scalaInstance, workArgs.compilerBridge)
      .withClassLoaderCache(classloaderCache)
    lastCompiler = scalaCompiler
    val compilers =
      ZincUtil.compilers(scalaInstance, ClasspathOptionsUtil.boot, None, scalaCompiler)

    val depMap = deps.collect { case ExternalDep(_, classpath, files) => classpath -> files }.toMap
    val lookup = AnxPerClasspathEntryLookup(file =>
      depMap
        .get(file)
        .map(files =>
          Analysis.Empty.copy(
            apis = analysesFormat.apis.read(files.apis),
            relations = analysesFormat.relations.read(files.relations)
          )
        )
     )

    val setup =
      val incOptions = IncOptions.create()
      val reporter = LoggedReporter(logger)
      val skip = false
      val zincFile: Path = null

      Setup.create(
        lookup,
        skip,
        zincFile,
        compilerCache,
        incOptions,
        reporter,
        Optional.empty[CompileProgress](),
        Array.empty[xsbti.T2[String, String]]
      )

    val inputs = Inputs.of(compilers, compileOptions, setup, previousResult)

    // compile
    val incrementalCompiler = IncrementalCompilerImpl()
    val compileResult =
      try incrementalCompiler.compile(inputs, logger)
      catch
        case _: CompileFailed => sys.exit(-1)
        case e: MatchError =>
          e.printStackTrace()
          System.err.println(e)
          sys.exit(1)
        case e: ClassFormatError =>
          System.err.println(e)
          sys.exit(1)
        case e: NoClassDefFoundError =>
          System.err.println(s"workArgs:$workArgs")
          println(s"work args:${args.mkString(" ")}")
          System.err.println(e)
          sys.exit(1)

    // create analyses
    analysisStore.set(AnalysisContents.create(compileResult.analysis, compileResult.setup))

    // create used deps
    val analysis = compileResult.analysis.asInstanceOf[Analysis]

    val usedDeps =
      deps.filter(Dep.used(deps, analysis.relations, lookup)).filter(_.file != scalaInstance.libraryJar.toPath)
    Files.write(workArgs.outputUsed, usedDeps.map(_.file.toString).sorted.asJava)

    // create jar
    val mains = analysis.infos.allInfos.values.toList
      .flatMap(_.getMainClasses.toList)
      .sorted

    val pw = PrintWriter(workArgs.mainManifest)
    try mains.foreach(pw.println)
    finally pw.close()

    val jarCreator = JarCreator(workArgs.outputJar)
    jarCreator.addDirectory(classesOutputDir)
    jarCreator.setCompression(true)
    jarCreator.setNormalize(true)
    jarCreator.setVerbose(false)
    for main <- mains.headOption do jarCreator.setMainClass(main)
    jarCreator.execute()

    // save persisted files
    if (workerArgs.usePersistence)
      try persistence.save()
      catch case NonFatal(e) => logger.warn(() => s"Failed to save cached analysis: $e")

    // clear temporary files
    FileUtil.delete(workArgs.tmpDir)
    Files.createDirectory(workArgs.tmpDir)

final class AnxPerClasspathEntryLookup(analyses: Path => Option[CompileAnalysis]) extends PerClasspathEntryLookup:
  private val Empty = Optional.empty[CompileAnalysis]

  override def analysis(classpathEntry: VirtualFile): Optional[CompileAnalysis] =
    classpathEntry match
      case file: PathBasedFile => analyses(file.toPath()).fold(Empty)(Optional.of(_))
      case _                   => Empty
  override def definesClass(classpathEntry: VirtualFile): DefinesClass =
    Locate.definesClass(classpathEntry)
