package rules_scala3.jmh

import java.io.File
import java.nio.file.{Path, Files, Paths, StandardCopyOption, FileAlreadyExistsException}
import java.util.zip.{ZipEntry, ZipInputStream}

import scala.concurrent.duration.Duration
import scala.concurrent.{Future, Await, ExecutionContext}

import com.google.devtools.build.buildjar.jarhelper.JarCreator
import org.openjdk.jmh.generators.bytecode.JmhBytecodeGenerator
import scopt.OParser

enum Generator:
  case Asm, Bytecode, Default
object Generator:
  def from(name: String): Generator =
    values.find(_.toString.equalsIgnoreCase(name)).getOrElse(throw RuntimeException("Unknown generator"))

final case class JmhWorkArguments(
    classpath: Vector[Path] = Vector.empty,
    generator: Generator = Generator.Default,
    sourcesJar: Path = Paths.get("."),
    resourcesJar: Path = Paths.get("."),
    tmpDir: Path = Paths.get(".")
)
object JmhWorkArguments:
  private val builder = OParser.builder[JmhWorkArguments]
  import builder.*

  private val parser = OParser.sequence(
    opt[File]("cp")
        .required()
        .unbounded()
        .action((cp, c) => c.copy(classpath = c.classpath :+ cp.toPath))
        .text("Compilation classpath"),
    opt[String]("generator")
        .optional()
        .action((g, c) => c.copy(generator = Generator.from(g)))
        .text("JMH generator"),
    opt[File]("sources_jar")
        .required()
        .action((jar, c) => c.copy(sourcesJar = jar.toPath))
        .text("Output sources jar"),
    opt[File]("resources_jar")
        .required()
        .action((jar, c) => c.copy(resourcesJar = jar.toPath))
        .text("Output resources jar"),
    opt[File]("tmp")
        .required()
        .action((tmp, c) => c.copy(tmpDir = tmp.toPath))
        .text("Temporary directory"),
  )

  def apply(args: collection.Seq[String]): Option[JmhWorkArguments] =
    OParser.parse(parser, args, JmhWorkArguments())

object JmhRunner:
  import ExecutionContext.Implicits.global

  def main(args: Array[String]): Unit =
    val workArgs = JmhWorkArguments(args).getOrElse(throw IllegalArgumentException(s"work args is invalid: ${args.mkString(" ")}"))

    val bytecodeDir = workArgs.tmpDir.resolve("bytecode")
    val sourcesDir = workArgs.tmpDir.resolve("sources")
    val resourcesDir = workArgs.tmpDir.resolve("resources")

    for dir <- Seq(bytecodeDir, sourcesDir, resourcesDir) do Files.createDirectory(dir)

    Future.sequence(workArgs.classpath.distinct.map(cp => Future(unzip(cp, bytecodeDir)))).await()

    JmhBytecodeGenerator.main(Array(bytecodeDir.toString, sourcesDir.toString, resourcesDir.toString, workArgs.generator.toString.toLowerCase))

    Future.sequence(Seq(
      Future(createJar(outputJar = workArgs.sourcesJar, dir = sourcesDir)),
      Future(createJar(outputJar = workArgs.resourcesJar, dir = resourcesDir))
    )).await()

  def unzip(zipFilePath: Path, destDirectory: Path): Unit =
    val zipInputStream = ZipInputStream(Files.newInputStream(zipFilePath))

    def extractEntry(entry: ZipEntry): Unit =
      val name = entry.getName
      if !name.startsWith("META-INF") && name.endsWith(".class") then
        val filePath = destDirectory.resolve(name)
        try Files.createDirectories(filePath.getParent)
        catch case _: FileAlreadyExistsException => ()
        try Files.copy(zipInputStream, filePath)
        catch case _: FileAlreadyExistsException => ()

    while
      zipInputStream.getNextEntry() match
        case entry: ZipEntry =>
          extractEntry(entry)
          true
        case null => false
    do ()

    zipInputStream.close()
  end unzip

  def createJar(outputJar: Path, dir: Path): Unit =
    val jarCreator = JarCreator(outputJar)
    jarCreator.addDirectory(dir)
    jarCreator.setCompression(false)
    jarCreator.setNormalize(true)
    jarCreator.setVerbose(false)
    jarCreator.execute()

  extension [T](fut: Future[T]) def await()(using ec: ExecutionContext): T = Await.result(fut, Duration.Inf)
