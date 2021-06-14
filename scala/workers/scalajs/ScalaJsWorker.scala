package rules_scala.workers.scalajs

import java.io.File
import java.nio.file.{Files, Path, Paths}

import org.scalajs.linker.interface.ModuleKind
import scopt.OParser

import rules_scala.common.worker.WorkerMain

object ScalaJsWorker extends WorkerMain[ScalaJsWorker.Arguments]:
  override def init(args: collection.Seq[String]): Arguments =
    Arguments(args).getOrElse(throw IllegalArgumentException(s"init args is invalid: ${args.mkString(" ")}"))

  override def work(workerArgs: Arguments, args: collection.Seq[String]): Unit =
    ???

  final case class Arguments(
      fullOpt: Boolean = false,
      moduleKind: ModuleKind = ModuleKind.NoModule,
      ecma2015: Boolean = false,
      dest: File = new File("."),
      classpath: Vector[Path] = Vector.empty,
      sourceJars: Vector[Path] = Vector.empty,
      sources: Vector[File] = Vector.empty,
  )
  object Arguments:
    private val builder = OParser.builder[Arguments]
    import builder.*

    private val parser = OParser.sequence(
      opt[Boolean]("full_opt").action((o, c) => c.copy(fullOpt = o)),
      opt[Boolean]("ecma2015").action((o, c) => c.copy(ecma2015 = o)),
      opt[File]("dest").required().action((f, c) => c.copy(dest = f)),
      opt[String]("module").action((m, c) =>
        c.copy(moduleKind = m match
          case "no"     => ModuleKind.NoModule
          case "common" => ModuleKind.CommonJSModule
          case "es"     => ModuleKind.ESModule
          case module   => throw IllegalArgumentException(s"Unknown module: $module. Valid modules: no, common, es")
        )
      ),
      opt[File]("cp")
        .unbounded()
        .optional()
        .action((cp, c) => c.copy(classpath = c.classpath :+ cp.toPath))
        .text("Compilation classpath"),
      opt[File]("source_jar")
        .unbounded()
        .optional()
        .action((s, c) => c.copy(sourceJars = c.sourceJars :+ s.toPath()))
        .text("Source jars"),
      arg[File]("<source>...")
        .unbounded()
        .optional()
        .action((s, c) => c.copy(sources = c.sources :+ s))
        .text("Source files")
    )

    def apply(args: collection.Seq[String]): Option[Arguments] = OParser.parse(parser, args, Arguments())
