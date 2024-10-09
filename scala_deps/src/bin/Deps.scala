package bin

import lib.Dependencies
import sbt.librarymanagement.syntax.*

object Deps:
  def main(args: Array[String]): Unit =
    given Vars = Vars(args.toIndexedSeq).getOrElse(sys.exit(2))

    given DepsCfg = DepsCfg(
      resolvers =  Dependencies.resolvers,
      replacements = Dependencies.replacements,
      dependencies = Dependencies.dependencies
    )

    MakeTree()
