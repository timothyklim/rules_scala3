package annex.scala.proto

import java.io.File
import java.nio.file.{Files, Paths, Path}
import java.util.Collections

import scala.jdk.CollectionConverters.*

import monocle.syntax.all.*
import protocbridge.{ProtocBridge, ProtocRunner}
import scalapb.ScalaPbCodeGenerator
import scopt.OParser

import rules_scala.common.worker.WorkerMain

final case class ProtoWorkArguments(
  outputDir: Path = Paths.get("."),
  protoc: File = new File("."),
  sources: Vector[String] = Vector.empty,
)
object ProtoWorkArguments:
  private val builder = OParser.builder[ProtoWorkArguments]
  import builder.*

  private val parser = OParser.sequence(
    opt[File]("output_dir")
      .required()
      .action((out, c) => c.focus(_.outputDir).replace(out.toPath))
      .text("Output dir"),
    opt[File]("protoc")
      .required()
      .action((p, c) => c.focus(_.protoc).replace(p))
      .text("Path to protoc"),
    arg[File]("<source>...")
      .unbounded()
      .optional()
      .action((s, c) => c.focus(_.sources).modify(_ :+ s.toString))
      .text("Source files"),
  )

  def apply(args: collection.Seq[String]): Option[ProtoWorkArguments] =
    OParser.parse(parser, args, ProtoWorkArguments())

object ScalaProtoWorker extends WorkerMain[Unit]:
  override def init(args: Option[Array[String]]): Unit = ()

  override def work(ctx: Unit, args: Array[String]): Unit =
    val workArgs = ProtoWorkArguments(args).getOrElse(throw IllegalArgumentException(s"work args is invalid: ${args.mkString(" ")}"))

    Files.createDirectories(workArgs.outputDir)

    ProtocBridge.runWithGenerators(
      ProtocRunner(workArgs.protoc.toString),
      List("scala" -> ScalaPbCodeGenerator),
      s"--scala_out=${workArgs.outputDir}" :: workArgs.sources.toList
    )
