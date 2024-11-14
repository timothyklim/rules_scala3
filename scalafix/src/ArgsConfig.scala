package rules_scala3.scalafix.src

import scopt.OParser

case class ArgsConfig(
  toolchain: Option[String] = None,
  scalafixOpts: Option[String] = None,
  targets: Seq[String] = Seq.empty,
  excludedTargets: Seq[String] = Seq.empty
)

object ArgsConfig:
  private val builder = OParser.builder[ArgsConfig]
  import builder.*

  private val parser = OParser.sequence(
    programName("scalafix-runner"),
    head("scalafix-runner", "1.0"),

    help('h', "help").text("Displays this usage text"),

    opt[String]('t', "toolchain")
      .required()
      .action((value, config) => config.copy(toolchain = Some(value)))
      .text("Required. Specifies the toolchain with which targets will be built"),

    opt[String]('o', "opts")
      .action((value, config) => config.copy(scalafixOpts = Some(value)))
      .text("Options passed to scalafix as a colon-separated string (e.g., :--verbose:--config)"),

    arg[String]("<target>...")
      .unbounded()
      .optional()
      .action((target, config) => config.copy(targets = config.targets :+ target))
      .text("Specifies the Bazel targets to be included"),

    checkConfig { config =>
      val (excluded, included) = config.targets.partition(_.startsWith("-"))
      Right(config.copy(excludedTargets = excluded.map(_.drop(1)), targets = included))
    }
  )

  def parse(args: Seq[String]): Option[ArgsConfig] = OParser.parse(parser, args, ArgsConfig())