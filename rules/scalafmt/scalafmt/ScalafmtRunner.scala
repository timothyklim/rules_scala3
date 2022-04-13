package annex.scalafmt

import java.io.File
import java.nio.file.{Files, Path, Paths}

import scala.annotation.tailrec
import scala.io.Codec

import org.scalafmt.config.Config
import org.scalafmt.Scalafmt
import org.scalafmt.sysops.FileOps
import scopt.{DefaultOParserSetup, OParser, OParserSetup}

import rules_scala.common.worker.WorkerMain
import rules_scala.workers.common.*

object ScalafmtRunner extends WorkerMain[Unit]:
  override def init(args: collection.Seq[String]): Unit = ()

  override def work(ctx: Unit, args: collection.Seq[String]): Unit =
    val workArgs = WorkArguments(args).getOrElse(throw IllegalArgumentException(s"work args is invalid: ${args.mkString(" ")}"))

    val source = FileOps.readFile(workArgs.input)(Codec.UTF8)

    val config = Config.fromHoconFile(workArgs.config).get
    @tailrec def format(code: String): String =
      val formatted = Scalafmt.format(code, config).get
      if code == formatted then code else format(formatted)

    val output =
      try format(source)
      catch
        case e @ (_: org.scalafmt.Error | _: scala.meta.parsers.ParseException) =>
          if config.runner.fatalWarnings then
            System.err.println(Color.Error("Exception thrown by Scalafmt and fatalWarnings is enabled"))
            throw e
          else
            System.err.println(Color.Warning("Unable to format file due to bug in scalafmt"))
            System.err.println(Color.Warning(e.toString))
            source
    Files.write(workArgs.output, output.getBytes)

  final case class WorkArguments(
      config: Path = Paths.get("."),
      input: Path = Paths.get("."),
      output: Path = Paths.get("."),
  )
  object WorkArguments:
    private val builder = OParser.builder[WorkArguments]
    import builder.*

    private val parser = OParser.sequence(
      opt[String]("config").required().action((p, c) => c.copy(config = pathFrom(p))),
      arg[String]("<input>").required().action((p, c) => c.copy(input = pathFrom(p))),
      arg[String]("<output>").required().action((p, c) => c.copy(output = pathFrom(p))),
    )

    def apply(args: collection.Seq[String]): Option[WorkArguments] =
      OParser.parse(parser, args, WorkArguments())

    private def pathFrom(path: String): Path = Paths.get(path.replace("~", sys.props.getOrElse("user.home", "")))
  end WorkArguments
