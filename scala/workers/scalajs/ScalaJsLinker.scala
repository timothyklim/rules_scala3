package rules_scala3.workers.scalajs

import java.nio.file.Path
import scala.concurrent.Await
import scala.concurrent.duration.Duration
import concurrent.ExecutionContext.Implicits.global

import org.scalajs.linker.{PathIRContainer, PathOutputFile, StandardImpl}
import org.scalajs.linker.interface.{LinkerOutput, ModuleInitializer, ModuleKind, Semantics, StandardConfig}
import org.scalajs.logging.ScalaConsoleLogger

object ScalaJsLinker:

  def link(args: ScalaJsWorker.Arguments) =
    val semantics = if args.fullOpt then Semantics.Defaults.optimized else Semantics.Defaults
    val useClosure = args.fullOpt && args.moduleKind != ModuleKind.ESModule
    val linkerConfig = StandardConfig()
      .withModuleKind(args.moduleKind)
      .withClosureCompilerIfAvailable(useClosure)
      .withOptimizer(args.fullOpt)
      .withSemantics(semantics)
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
