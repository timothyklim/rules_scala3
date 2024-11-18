package rules_scala3.rules.scalafix.src

object Main:
  def main(args: Array[String]): Unit =
    ArgsConfig.parse(args.toIndexedSeq) match
      case Some(config) =>
        println("Parsed Arguments:")
        println(s"Toolchain: ${config.toolchain.getOrElse("None")}")
        println(s"Scalafix Options: ${config.scalafixOpts.getOrElse("None")}")
        println(s"Targets: ${config.targets.mkString(", ")}")
        println(s"Excluded Targets: ${config.excludedTargets.mkString(", ")}")
      case None =>
        println("Failed to parse arguments.")
        sys.exit(2)
