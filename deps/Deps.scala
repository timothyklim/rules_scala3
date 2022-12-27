package rules_scala3.deps

import sbt.librarymanagement.*
import sbt.librarymanagement.syntax.*

object Deps:
  def main(args: Array[String]): Unit =
    val module = "commons-io" % "commons-io" % "2.5"
    println(s"module:$module")
