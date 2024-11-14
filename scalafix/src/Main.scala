package rules_scala3.scalafix.src

object Main:
  def main(args: Array[String]): Unit =
    given Vars = ArgsConfig(args.toIndexedSeq).getOrElse(sys.exit(2))