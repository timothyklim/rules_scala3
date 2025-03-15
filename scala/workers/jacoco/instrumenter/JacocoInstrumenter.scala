package rules_scala3
package workers.jacoco.instrumenter

import common.worker.WorkerMain

import java.io.{BufferedInputStream, BufferedOutputStream}
import java.net.URI
import java.nio.file.*
import java.nio.file.attribute.BasicFileAttributes
import java.util.Collections
import org.jacoco.core.instr.Instrumenter
import org.jacoco.core.runtime.OfflineInstrumentationAccessGenerator
import scala.jdk.CollectionConverters.*
import scopt.OParser

final case class JacocoArgs(jars: Vector[(Path, Path)] = Vector.empty)

object JacocoArgs:
  private val builder = OParser.builder[JacocoArgs]
  import builder.*

  private val parser = OParser.sequence(
    opt[String]("jar")
      .unbounded()
      .required()
      .action((arg, c) => c.copy(jars = c.jars :+ parseJar(arg)))
      .text("Jar to instrument in the format inpath=outpath")
  )

  def apply(args: collection.Seq[String]): Option[JacocoArgs] =
    OParser.parse(parser, args, JacocoArgs())

  private def parseJar(arg: String): (Path, Path) =
    arg.split("=") match
      case Array(in, out) => (Paths.get(in), Paths.get(out))
      case _              => sys.error(s"Expected input=output for argument: $arg")

object JacocoInstrumenter extends WorkerMain[Unit]:
  override def init(args: collection.Seq[String]): Unit = ()

  override def work(ctx: Unit, args: collection.Seq[String]): Unit =
    val jacocoArgs = JacocoArgs(args).getOrElse(throw IllegalArgumentException(s"Invalid arguments: ${args.mkString(" ")}"))

    val jacoco = new Instrumenter(new OfflineInstrumentationAccessGenerator)

    jacocoArgs.jars.foreach { case (inPath, outPath) =>
      val inFS = FileSystems.newFileSystem(inPath, Collections.emptyMap())
      val outFS = FileSystems.newFileSystem(URI.create("jar:" + outPath.toUri), Collections.singletonMap("create", "true"))

      val roots = inFS.getRootDirectories.asScala.toList
      val instrumentVisitor = new SimpleFileVisitor[Path]:
        override def visitFile(inPath: Path, attrs: BasicFileAttributes): FileVisitResult =
          val outPath = outFS.getPath(inPath.toString)
          Files.createDirectories(outPath.getParent)
          if inPath.toString.endsWith(".class") then
            val inStream = new BufferedInputStream(Files.newInputStream(inPath))
            val outStream = new BufferedOutputStream(Files.newOutputStream(outPath, StandardOpenOption.CREATE_NEW))
            jacoco.instrument(inStream, outStream, inPath.toString)
            inStream.close()
            outStream.close()
            Files.copy(inPath, outFS.getPath(outPath.toString + ".uninstrumented"))
          else Files.copy(inPath, outPath)
          FileVisitResult.CONTINUE

      roots.foreach(Files.walkFileTree(_, instrumentVisitor))

      inFS.close()
      outFS.close()
    }
