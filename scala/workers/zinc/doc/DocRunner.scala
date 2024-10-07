package rules_scala
package workers.zinc.doc

import java.io.File
import java.net.URLClassLoader
import java.nio.file.{Files, NoSuchFileException}

import common.worker.WorkerMain
import sbt.internal.inc.{LoggedReporter, PlainVirtualFile, PlainVirtualFileConverter, ZincUtil}
import sbt.internal.inc.classpath.ClassLoaderCache
import scopt.OParser
import workers.common.{AnnexLogger, AnnexScalaInstance, FileUtil, LogLevel}
import xsbti.VirtualFile

final case class DocArgs(
                          cp: Seq[File] = Seq.empty,
                          compilerBridge: File = new File(""),
                          compilerCp: Seq[File] = Seq.empty,
                          option: Seq[String] = Seq.empty,
                          logLevel: LogLevel = LogLevel.Warn,
                          sourceJars: Seq[File] = Seq.empty,
                          tmp: File = new File(""),
                          outputHtml: File = new File(""),
                          sources: Seq[File] = Seq.empty
                        )

object DocArgs:
  private val builder = OParser.builder[DocArgs]
  import builder.*

  private val parser = OParser.sequence(
    programName("doc"),
    head("doc", "1.0"),
    opt[Seq[File]]("cp")
      .valueName("<path1>,<path2>...")
      .action((x, c) => c.copy(cp = x))
      .text("Compilation classpath"),
    opt[File]("compiler_bridge")
      .required()
      .valueName("<path>")
      .action((x, c) => c.copy(compilerBridge = x))
      .text("Compiler bridge"),
    opt[Seq[File]]("compiler_cp")
      .valueName("<path1>,<path2>...")
      .action((x, c) => c.copy(compilerCp = x))
      .text("Compiler classpath"),
    opt[Seq[String]]("option")
      .valueName("<option1>,<option2>...")
      .action((x, c) => c.copy(option = x))
      .text("Compiler options"),
    opt[LogLevel]("log_level")
      .valueName("<log_level>")
      .action((x, c) => c.copy(logLevel = x))
      .text("Log level")
      .withFallback(() => LogLevel.Warn),
    opt[Seq[File]]("source_jars")
      .valueName("<path1>,<path2>...")
      .action((x, c) => c.copy(sourceJars = x))
      .text("Source jars"),
    opt[File]("tmp")
      .required()
      .valueName("<path>")
      .action((x, c) => c.copy(tmp = x))
      .text("Temporary directory"),
    opt[File]("output_html")
      .required()
      .valueName("<path>")
      .action((x, c) => c.copy(outputHtml = x))
      .text("Output directory"),
    arg[Seq[File]]("<sources>...")
      .unbounded()
      .action((x, c) => c.copy(sources = x))
      .text("Source files")
  )

  def parse(args: collection.Seq[String]): Option[DocArgs] =
    OParser.parse(parser, args, DocArgs())

object DocRunner extends WorkerMain[Unit]:

  private val topLoader = new URLClassLoader(Array(), getClass().getClassLoader)
  private val classloaderCache = new ClassLoaderCache(new URLClassLoader(Array()))

  override def init(args: collection.Seq[String]): Unit = ()

  override def work(ctx: Unit, args: collection.Seq[String]): Unit =
    val docArgs = DocArgs.parse(args).getOrElse(throw IllegalArgumentException(s"Invalid arguments: ${args.mkString(" ")}"))

    val tmpDir = docArgs.tmp.toPath
    try FileUtil.delete(tmpDir)
    catch case _: NoSuchFileException => ()

    val sources = docArgs.sources ++
      docArgs.sourceJars.zipWithIndex.flatMap { case (jar, i) =>
        FileUtil.extractZip(jar.toPath, tmpDir.resolve("src").resolve(i.toString))
      }

    val scalaInstance = new AnnexScalaInstance(topLoader, classloaderCache, docArgs.compilerCp.toArray)

    val logger = new AnnexLogger(docArgs.logLevel)

    val scalaCompiler = ZincUtil
      .scalaCompiler(scalaInstance, docArgs.compilerBridge)
      .withClassLoaderCache(classloaderCache)

    val classpath = docArgs.cp
    val output = docArgs.outputHtml
    output.mkdirs()
    val options = docArgs.option
    val reporter = new LoggedReporter(10, logger)

    val virtualSources: Seq[VirtualFile] = sources.map(f => PlainVirtualFile(f.toPath))
    val virtualClasspath: Seq[VirtualFile] = (scalaInstance.libraryJar +: classpath).map(f => PlainVirtualFile(f.toPath))

    scalaCompiler.doc(virtualSources, virtualClasspath, PlainVirtualFileConverter.converter, output.toPath, options, logger, reporter)

    try FileUtil.delete(tmpDir)
    catch
      case _: NoSuchFileException =>
        Files.createDirectory(tmpDir)
