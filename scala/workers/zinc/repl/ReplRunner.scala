package rules_scala
package workers.zinc.repl

import workers.common.{Bazel, LogLevel, AnnexLogger, AnnexScalaInstance, FileUtil, TopClassLoader}

import java.io.File
import java.nio.file.{Files, Paths, Path}
import java.net.URLClassLoader
import java.util.Collections

import scala.jdk.CollectionConverters.*

import sbt.internal.inc.{ZincUtil, PlainVirtualFile, MappedFileConverter}
import sbt.internal.inc.classpath.ClassLoaderCache
import scopt.OParser
import xsbti.Logger

final case class ReplRunnerArguments(
    logLevel: LogLevel = LogLevel.Warn
)
object ReplRunnerArguments:
  private val builder = OParser.builder[ReplRunnerArguments]
  import builder.*

  private val parser = OParser.sequence(
    opt[LogLevel]("log_level").action((l, c) => c.copy(logLevel = l)).text("Log level")
  )

  def apply(args: collection.Seq[String]): Option[ReplRunnerArguments] =
    OParser.parse(parser, args, ReplRunnerArguments())

final case class ReplWorkArguments(
    classpath: Vector[Path] = Vector.empty,
    compilerBridge: Path = Paths.get("."),
    compilerOption: Vector[String] = Vector.empty,
    compilerClasspath: Vector[Path] = Vector.empty
)
object ReplWorkArguments:
  private val builder = OParser.builder[ReplWorkArguments]
  import builder.*

  private val parser = OParser.sequence(
    opt[File]("cp")
      .unbounded()
      .optional()
      .action((f, c) => c.copy(classpath = c.classpath :+ f.toPath()))
      .text("Compilation classpath"),
    opt[File]("compiler_bridge")
      .required()
      .action((bridge, c) => c.copy(compilerBridge = bridge.toPath()))
      .text("Compiler bridge"),
    opt[String]("compiler_option")
      .unbounded()
      .optional()
      .action((opt, c) => c.copy(compilerOption = c.compilerOption :+ opt))
      .text("Compiler option"),
    opt[File]("compiler_cp")
      .unbounded()
      .optional()
      .action((cp, c) => c.copy(compilerClasspath = c.compilerClasspath :+ cp.toPath()))
      .text("Compiler classpath")
  )

  def apply(args: collection.Seq[String]): Option[ReplWorkArguments] =
    OParser.parse(parser, args, ReplWorkArguments())

object ReplRunner:
  def main(args: Array[String]): Unit =
    val runArgs = ReplRunnerArguments(Bazel.parseParams(args)).getOrElse(throw IllegalArgumentException(s"args is invalid: ${args.mkString(" ")}"))

    val runPath = Paths.get(sys.props("bazel.runPath"))

    val replArgFile = Paths.get(sys.props("scalaAnnex.test.args"))
    val workerArgs = Bazel.parseParams(Files.readAllLines(replArgFile).asScala)
    val workArgs = ReplWorkArguments(workerArgs).getOrElse(throw IllegalArgumentException(s"work args is invalid: ${workerArgs.mkString(" ")}"))

    val urls = workArgs.classpath.map(p => runPath.resolve(p).toUri.toURL)

    val compilerClasspath = workArgs.compilerClasspath.map(p => runPath.resolve(p).toFile)
    val scalaInstance = AnnexScalaInstance(topLoader, classloaderCache, compilerClasspath.toArray)

    val logger = AnnexLogger(runArgs.logLevel)

    val scalaCompiler = ZincUtil.scalaCompiler(scalaInstance, runPath.resolve(workArgs.compilerBridge).toFile)

    val classpath = workArgs.classpath.map(p => runPath.resolve(p).toFile)

    val refs = compilerClasspath.view.concat(classpath).map(f => PlainVirtualFile(f.toPath())).to(Seq)
    scalaCompiler.console(refs, MappedFileConverter.empty, workArgs.compilerOption, "", "", logger)()

  private val topLoader = TopClassLoader(getClass().getClassLoader())
  private val classloaderCache = ClassLoaderCache(URLClassLoader(Array.empty))
