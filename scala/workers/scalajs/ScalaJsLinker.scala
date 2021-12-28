package rules_scala.workers.scalajs

import java.nio.file.Path
import scala.concurrent.Await
import scala.concurrent.duration.Duration
import concurrent.ExecutionContext.Implicits.global

import org.scalajs.linker.{PathIRContainer, PathOutputFile, StandardImpl}
import org.scalajs.linker.interface.{LinkerOutput, ModuleInitializer, ModuleKind, Semantics, StandardConfig}
import org.scalajs.logging.ScalaConsoleLogger

object ScalaJsLinker:

//  private val cache = mutable.Map.empty[LinkerInput, WeakReference[Linker]]
//
//  def reuseOrCreate(input: LinkerInput): Linker = cache.get(input) match
//    case Some(WeakReference(linker)) => linker
//    case _ =>
//      val newLinker = createLinker(input)
//      cache.update(input, WeakReference(newLinker))
//      newLinker


  def link(args: ScalaJsWorker.Arguments) =
    val linkerConfig = StandardConfig()
      .withModuleKind(args.moduleKind)
      .withOptimizer(true)
      .withSemantics(Semantics.Defaults.optimized)
    val linker = StandardImpl.linker(linkerConfig)

    val cache = StandardImpl.irFileCache().newCache
    val sourceIRs = PathIRContainer
      .fromClasspath(args.sourcesAndLibs.toSeq)
      .flatMap((irContainer, _) => cache.cached(irContainer))
    val jsFile = args.dest.toPath
    val output = LinkerOutput(PathOutputFile(jsFile))
      .withJSFileURI(java.net.URI.create(jsFile.getFileName.toString))
    val mainInitializer = args.mainClass.map { mainCls =>
      if args.mainMethodWithArgs then ModuleInitializer.mainMethodWithArgs(mainCls, args.mainMethod)
      else ModuleInitializer.mainMethod(mainCls, args.mainMethod)
    }
    val logger = new ScalaConsoleLogger()
    val result =
      for
        irFiles <- sourceIRs
        _ <- linker.link(irFiles, mainInitializer.toList, output, logger)
      yield ()
    Await.result(result, Duration.Inf)
end ScalaJsLinker

//  final case class LinkerInput(fullOpt: Boolean, moduleKind: ModuleKind, useECMAScript2015: Boolean, dest: File)
//
//  def reuseOrCreate(input: LinkerInput): Linker = cache.get(input) match
//    case Some(WeakReference(linker)) => linker
//    case _ =>
//      val newLinker = createLinker(input)
//      cache.update(input, WeakReference(newLinker))
//      newLinker
//
//  private def createLinker(input: LinkerInput): Linker =
//    val semantics = if input.fullOpt then Semantics.Defaults.optimized else Semantics.Defaults
//    val config = StandardConfig()
//      .withClosureCompilerIfAvailable(input.fullOpt)
//      .withESFeatures(_.withUseECMAScript2015(input.useECMAScript2015))
//      .withModuleKind(input.moduleKind)
//      .withOptimizer(input.fullOpt)
//      .withSemantics(semantics)
//    StandardImpl.linker(config)
//
//  private val cache = mutable.Map.empty[LinkerInput, WeakReference[Linker]]
//
//  def link(
//      sources: Array[File],
//      libraries: Array[File],
//      dest: File,
//      main: String | Null,
//      testBridgeInit: Boolean,
//      fullOpt: Boolean,
//      moduleKind: ModuleKind,
//      useECMAScript2015: Boolean
//  ): File =
//    val linker = reuseOrCreate(LinkerInput(fullOpt = fullOpt, moduleKind, useECMAScript2015 = useECMAScript2015, dest))
//    val cache = StandardImpl.irFileCache().newCache
//    val sourceIRsFuture = Future.sequence(sources.toSeq.map(f => PathIRFile(f.toPath())))
//    val irContainersPairs = PathIRContainer.fromClasspath(libraries.map(_.toPath()))
//    val libraryIRsFuture = irContainersPairs.flatMap(pair => cache.cached(pair._1))
//    val jsFile = dest.toPath()
//    val sourceMap = jsFile.resolveSibling(s"${jsFile.getFileName()}.map")
//    val linkerOutput = LinkerOutput(PathOutputFile(jsFile))
//      .withJSFileURI(URI.create(jsFile.getFileName.toString))
//      .withSourceMap(PathOutputFile(sourceMap))
//      .withSourceMapURI(URI.create(sourceMap.getFileName.toString))
//    val logger = ScalaConsoleLogger()
//
//    val moduleInitializers = Seq.newBuilder[ModuleInitializer]
//    main match
//      case cls: String => moduleInitializers += ModuleInitializer.mainMethodWithArgs(cls, "main")
//      case null        => ()
//    if testBridgeInit then
//      moduleInitializers += ModuleInitializer.mainMethod(TestAdapterInitializer.ModuleClassName, TestAdapterInitializer.MainMethodName)
//
//    val resultFuture = for
//      sourceIRs <- sourceIRsFuture
//      libraryIRs <- libraryIRsFuture
//      _ <- linker.link(sourceIRs ++ libraryIRs, moduleInitializers.result(), linkerOutput, logger)
//    yield dest
//
//    Await.result(resultFuture, Duration.Inf)
