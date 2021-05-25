package annex.scala.proto

import java.io.{File, FileOutputStream}
import java.nio.file.{Files, Paths, Path}
import java.util.jar.{JarEntry, JarFile}
import java.util.Collections

import scala.annotation.tailrec
import scala.collection.mutable
import scala.jdk.CollectionConverters.*

import protocbridge.{ProtocBridge, ProtocRunner, ProtocCodeGenerator}
import scalapb.{ScalaPbCodeGenerator, GeneratorOption}
import scalapb.GeneratorOption.*
import scalapb.grpcweb.GrpcWebCodeGenerator
import scopt.OParser

import rules_scala.workers.common.Bazel
import rules_scala.common.worker.WorkerMain

final case class ProtoWorkArguments(
    outputDir: Path = Paths.get("."),
    protoc: File = new File("."),
    protoPath: Path = Paths.get("."),
    includeJars: Vector[Path] = Vector.empty,
    include: Set[Path] = Set.empty,
    sources: Vector[Path] = Vector.empty,
    genOptions: Set[String] = Set.empty,
    grpcWeb: Boolean = false
)
object ProtoWorkArguments:
  private val builder = OParser.builder[ProtoWorkArguments]
  import builder.*

  private val parser = OParser.sequence(
    opt[File]("output_dir")
      .required()
      .action((out, c) => c.copy(outputDir = out.toPath))
      .text("Output dir"),
    opt[File]("protoc")
      .required()
      .action((p, c) => c.copy(protoc = p))
      .text("Path to protoc"),
    opt[File]("proto_path")
      .required()
      .action((p, c) => c.copy(protoPath = p.toPath()))
      .text("protoc --proto_path"),
    opt[File]("include_jar")
      .unbounded()
      .optional()
      .action((j, c) => c.copy(includeJars = c.includeJars :+ j.toPath()))
      .text("JAR to include in protoc --proto_path"),
    opt[File]("include")
      .unbounded()
      .optional()
      .action((j, c) => c.copy(include = c.include + j.toPath()))
      .text("Path to include in protoc --proto_path"),
    opt[String]("gen_option")
      .unbounded()
      .optional()
      .validate {
        case o if ScalaProtoWorker.genOptions.contains(o) => success
        case _                                            => failure(s"Value must be one of: ${ScalaProtoWorker.genOptions.mkString(", ")}")
      }
      .action((o, c) => c.copy(genOptions = c.genOptions + o))
      .text("ScalaPB gen options"),
    opt[Unit]("grpc_web")
      .optional()
      .action((_, c) => c.copy(grpcWeb = true))
      .text("Enable gRPC web generator"),
    arg[File]("<source>...")
      .unbounded()
      .optional()
      .action((s, c) => c.copy(sources = c.sources :+ s.toPath()))
      .text("Source files")
  )

  def apply(args: collection.Seq[String]): Option[ProtoWorkArguments] =
    OParser.parse(parser, args, ProtoWorkArguments())

object ScalaProtoWorker extends WorkerMain[Unit]:
  override def init(args: Option[Array[String]]): Unit = ()

  override def work(ctx: Unit, args: Array[String]): Unit =
    val workArgs =
      ProtoWorkArguments(Bazel.parseParams(args)).getOrElse(throw IllegalArgumentException(s"work args is invalid: ${args.mkString(" ")}"))

    val protoPath = resolve(workArgs.protoPath)
    Files.createDirectories(protoPath)

    val outputDir = resolve(workArgs.outputDir)
    Files.createDirectories(outputDir)

    for jar <- workArgs.includeJars do unzipProto(jarFile = resolve(jar), protoPath = protoPath)

    val options = List.newBuilder[String]
    options += s"-I$protoPath"
    options += s"-I$root"

    for include <- workArgs.include do options += s"-I${resolve(include)}"

    for src <- workArgs.sources do if !workArgs.include.exists(src.startsWith(_)) then options += src.toString

    val scalaOut = workArgs.genOptions match
      case options if options.nonEmpty => s"${options.mkString(",")}:$outputDir"
      case _                           => outputDir
    options += s"--scala_out=$scalaOut"

    val generators = List.newBuilder[(String, ProtocCodeGenerator)]
    generators += "scala" -> ScalaPbCodeGenerator
    if workArgs.grpcWeb then
      generators += "grpc-web" -> GrpcWebCodeGenerator
      options += s"--grpc-web_out=$scalaOut"

    ProtocBridge.runWithGenerators(ProtocRunner(workArgs.protoc.toString), generators.result(), options.result()) match
      case 0 => ()
      case code =>
        System.err.println(s"Exit code: $code")
        sys.exit(code)

  private def unzipProto(jarFile: Path, protoPath: Path): Unit =
    val jar = JarFile(jarFile.toFile())

    @tailrec def f(iter: Iterator[JarEntry], valid: Boolean): Boolean =
      if iter.hasNext then
        val entry = iter.next()
        if entry.getName().endsWith(".proto") then
          val entryFile = protoPath.resolve(entry.getName()).toFile()
          entryFile.getParentFile() match
            case parentDir: File if !parentDir.exists() =>
              Files.createDirectories(parentDir.toPath())
            case _ =>

          val out = FileOutputStream(entryFile, false)
          try jar.getInputStream(entry).transferTo(out)
          finally out.close()

          f(iter, valid = true)
        else f(iter, valid)
      else valid

    try
      f(jar.entries().asScala, valid = false) match
        case true => ()
        case false =>
          System.err.println(s"$jarFile does not contain any `.proto` file")
          sys.exit(-1)
    finally jar.close()

  private val root = Paths.get("").toAbsolutePath()

  private def resolve(file: Path): Path =
    if file.startsWith(root) then file else root.resolve(file)

  val genOptions: Set[String] = Set(
    FlatPackage,
    JavaConversions,
    Grpc,
    SingleLineToProtoString,
    AsciiFormatToString,
    NoLenses
  ).map(_.toString)
