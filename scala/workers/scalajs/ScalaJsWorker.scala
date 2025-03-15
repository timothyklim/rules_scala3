package rules_scala3.workers.scalajs

import java.io.File
import java.nio.file.{Files, Path, Paths}

import org.scalajs.linker.interface.ModuleKind
import scopt.OParser

import rules_scala3.workers.common.Bazel
import rules_scala3.common.worker.WorkerMain

object ScalaJsWorker: // extends WorkerMain[ScalaJsWorker.Arguments]:
//  override def init(args: collection.Seq[String]): Arguments =
//    Arguments(args).getOrElse(throw IllegalArgumentException(s"init args is invalid: ${args.mkString(" ")}"))
//
//  override def work(workerArgs: Arguments, args: collection.Seq[String]): Unit =
//    ???
//
  def main(args: Array[String]): Unit =
    val runArgs = Arguments(Bazel.parseParams(args)).getOrElse(throw IllegalArgumentException(s"args is invalid: ${args.mkString(" ")}"))
    ScalaJsLinker.link(runArgs)

  final case class Arguments(
      mainClass: Option[String] = None,
      mainMethod: String = "main",
      mainMethodWithArgs: Boolean = false,
      fullOpt: Boolean = false,
      sourcesAndLibs: Vector[Path] = Vector.empty,
      dest: File = File("."),
      moduleKind: ModuleKind = ModuleKind.NoModule
  )
  object Arguments:
    private val builder = OParser.builder[Arguments]
    import builder.*

    private val parser = OParser.sequence(
      opt[Option[String]]("main-class").optional().action((o, c) => c.copy(mainClass = o)),
      opt[String]("main-method").optional().action((o, c) => c.copy(mainMethod = o)),
      opt[Boolean]("with-args").optional().action((o, c) => c.copy(mainMethodWithArgs = o)),
      opt[Boolean]("full-opt").optional().action((o, c) => c.copy(fullOpt = o)),
      opt[File]("dest").required().action((f, c) => c.copy(dest = f)),
      opt[String]("module")
        .optional()
        .action((m, c) =>
          c.copy(moduleKind = m match
            case "no"     => ModuleKind.NoModule
            case "common" => ModuleKind.CommonJSModule
            case "es"     => ModuleKind.ESModule
            case module   => throw IllegalArgumentException(s"Unknown module: $module. Valid modules: no, common, es")
          )
        ),
      arg[File]("<file>...")
        .required()
        .unbounded()
        .action((cp, c) => c.copy(sourcesAndLibs = c.sourcesAndLibs :+ cp.toPath))
        .text("Files with source archives and libraries")
    )

    def apply(args: collection.Seq[String]): Option[Arguments] = OParser.parse(parser, args, Arguments())
