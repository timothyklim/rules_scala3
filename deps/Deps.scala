package rules_scala3.deps

import java.io.File
import sbt.librarymanagement.syntax.*

@main def Deps(args: String*): Unit =
  // parse args
  vars = Vars(
    projectRoot = new File("/home/name_snrl/work/forks/rules_scala3"),
    depsDirName = "3rdparty",
    bazelExtFileName = "workspace.bzl",
    buildFilesDirName = "jvm",
    buildFileName = "BUILD",
    scalaVersion = "3.3.0",
    buildFileHeader = """load("@io_bazel_rules_scala//scala:scala_import.bzl", "scala_import")"""
  )

// Replacements are not handled by `librarymanagement`. any Scala prefix in the name will be dropped.
// It also doesn't matter whether you use double `%` to get the Scala version or not.
  val replacements = Map(
      "org.scala-lang" % "scala-compiler" -> "@io_bazel_rules_scala_scala_compiler//:io_bazel_rules_scala_scala_compiler",
      "org.scala-lang" % "scala-library" -> "@io_bazel_rules_scala_scala_library//:io_bazel_rules_scala_scala_library",
      "org.scala-lang" % "scala-reflect" -> "@io_bazel_rules_scala_scala_reflect//:io_bazel_rules_scala_scala_reflect",
      "org.scala-lang.modules" % "scala-parser-combinators" -> "@io_bazel_rules_scala_scala_parser_combinators//:io_bazel_rules_scala_scala_parser_combinators",
      "org.scala-lang.modules" % "scala-xml" -> "@io_bazel_rules_scala_scala_xml//:io_bazel_rules_scala_scala_xml",
  )

  val dependencies = Vector(
    "org.scala-sbt" % "librarymanagement-core_3" % "2.0.0-alpha12",
    "org.scala-sbt" % "librarymanagement-coursier_3" % "2.0.0-alpha6",
  )

  MakeTree(dependencies, replacements)
