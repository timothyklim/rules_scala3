package annex.scala.proto

import higherkindness.rules_scala.common.worker.WorkerMain
import java.io.File
import java.nio.file.{Files, Paths}
import java.util.Collections
import net.sourceforge.argparse4j.ArgumentParsers
import net.sourceforge.argparse4j.impl.Arguments
import net.sourceforge.argparse4j.inf.ArgumentParser
import protocbridge.{ProtocBridge, ProtocRunner}
import scala.jdk.CollectionConverters.*
import scalapb.ScalaPbCodeGenerator

object ScalaProtoWorker extends WorkerMain[Unit]:
  private val argParser: ArgumentParser =
    val parser = ArgumentParsers.newFor("proto").addHelp(true).fromFilePrefix("@").build
    parser
      .addArgument("--output_dir")
      .help("Output dir")
      .metavar("output_dir")
      .`type`(Arguments.fileType.verifyCanCreate)
      .required(true)
    parser
      .addArgument("--protoc")
      .help("Path to protoc")
      .metavar("protoc")
      .`type`(Arguments.fileType.verifyCanRead().verifyExists())
      .required(true)
    parser
      .addArgument("sources")
      .help("Source files")
      .metavar("source")
      .nargs("*")
      .`type`(Arguments.fileType.verifyCanRead.verifyIsFile)
      .setDefault(Collections.emptyList)
    parser

  override def init(args: Option[Array[String]]): Unit = ()

  override def work(ctx: Unit, args: Array[String]): Unit =
    val namespace = argParser.parseArgs(args)
    val sources = namespace.getList[File]("sources").asScala.toList

    val scalaOut = namespace.get[File]("output_dir").toPath
    Files.createDirectories(scalaOut)

    val params = s"--scala_out=$scalaOut" :: sources.map(_.getPath)

    ProtocBridge.runWithGenerators(
      ProtocRunner(namespace.get[File]("protoc").toString),
      List("scala" -> ScalaPbCodeGenerator),
      params
    )
