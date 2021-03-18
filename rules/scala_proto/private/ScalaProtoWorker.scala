package annex.scala.proto

import java.io.{File, FileOutputStream}
import java.nio.file.{Files, Paths, Path}
import java.util.jar.{JarEntry, JarFile}
import java.util.Collections

import scala.collection.mutable
import scala.jdk.CollectionConverters.*

import monocle.syntax.all.*
import protocbridge.{ProtocBridge, ProtocRunner}
import scalapb.ScalaPbCodeGenerator
import scopt.OParser

import rules_scala.common.worker.WorkerMain

final case class ProtoWorkArguments(
  outputDir: Path = Paths.get("."),
  protoc: File = new File("."),
  protoPath: Path = Paths.get("."),
  includeJars: Vector[Path] = Vector.empty,
  sources: Vector[File] = Vector.empty,
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
    opt[File]("proto_path")
      .required()
      .action((p, c) => c.focus(_.protoPath).replace(p.toPath()))
      .text("protoc --proto_path"),
    opt[File]("include_jar")
      .unbounded()
      .optional()
      .action((j, c) => c.focus(_.includeJars).modify(_ :+ j.toPath()))
      .text("JAR to include in protoc --proto_path"),
    arg[File]("<source>...")
      .unbounded()
      .optional()
      .action((s, c) => c.focus(_.sources).modify(_ :+ s))
      .text("Source files"),
  )

  def apply(args: collection.Seq[String]): Option[ProtoWorkArguments] =
    OParser.parse(parser, args, ProtoWorkArguments())

object ScalaProtoWorker extends WorkerMain[Unit]:
  override def init(args: Option[Array[String]]): Unit = ()

  override def work(ctx: Unit, args: Array[String]): Unit =
    val workArgs = ProtoWorkArguments(args).getOrElse(throw IllegalArgumentException(s"work args is invalid: ${args.mkString(" ")}"))

    val protoPath = resolve(workArgs.protoPath)
    Files.createDirectories(protoPath)

    val outputDir = resolve(workArgs.outputDir)
    Files.createDirectories(outputDir)

    for (jar <- workArgs.includeJars)
      unzipProto(jarFile = resolve(jar), protoPath = protoPath)

    val optionsBuilder = List.newBuilder[String]
    optionsBuilder += s"--scala_out=$outputDir"
    optionsBuilder += s"-I$protoPath"

    val parentSrcs = mutable.HashSet.empty[File]
    for (src <- workArgs.sources) do
      src.getParentFile() match
        case parentDir: File if !parentSrcs.contains(parentDir) =>
          optionsBuilder += s"-I$parentDir"
          parentSrcs += parentDir
        case _ =>

    for (src <- workArgs.sources) do optionsBuilder += src.toString

    val options = optionsBuilder.result()
    println(s"options:$options")
    println(s"outputDir:${outputDir.toFile.exists()}\nprotoPath:${protoPath.toFile.exists()}")

    ProtocBridge.runWithGenerators(
      ProtocRunner(workArgs.protoc.toString),
      List("scala" -> ScalaPbCodeGenerator),
      options
    ) match
      case 0 => ()
      case code =>
        System.err.println(s"Exit code: $code")
        sys.exit(code)

  private def unzipProto(jarFile: Path, protoPath: Path): Unit =
    val jar = JarFile(jarFile.toFile())
    try
      for (entry <- jar.entries().asScala) do
        if (entry.getName().endsWith(".proto"))
          val entryFile = protoPath.resolve(entry.getName()).toFile()
          println(s"entryFile:$entryFile")
          entryFile.getParentFile() match
            case parentDir: File if !parentDir.exists() =>
              println(s"Files.createDirectories($parentDir)")
              Files.createDirectories(parentDir.toPath())
            case _ =>
          val out = FileOutputStream(entryFile, false)
          try jar.getInputStream(entry).transferTo(out)
          finally out.close()
    finally jar.close()

  private val root = Paths.get("").toAbsolutePath()

  private def resolve(file: Path): Path = if (file.startsWith(root)) file else root.resolve(file)
