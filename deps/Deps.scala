package rules_scala3.deps

import java.io.File

import sbt.librarymanagement.DependencyBuilders.OrganizationArtifactName
import sbt.librarymanagement.syntax.*

object Deps:
  def main(args: Array[String]): Unit =
    val projectRoot = args.headOption.getOrElse(throw RuntimeException("Pass path as an argument"))

    // parse args
    given Vars = Vars(
      projectRoot = File(projectRoot),
      depsDirName = "3rdparty",
      bazelExtFileName = "workspace.bzl",
      buildFilesDirName = "jvm",
      buildFileName = "BUILD",
      scalaVersion = "3.3.0",
      buildFileHeader = """load("@rules_scala3//rules:scala.bzl", "scala_import")"""
    )

    // Replacements are not handled by `librarymanagement`. any Scala prefix in the name will be dropped.
    // It also doesn't matter whether you use double `%` to get the Scala version or not.
    val replacements = Map[OrganizationArtifactName, String](
        "org.scala-lang" % "scala3-library" -> "@scala_library_3_3_1//jar",
        "org.scala-lang" % "scala-library" -> "@scala_library_2_13_11//jar",
        "org.scala-lang" % "scala-reflect" -> "@scala_reflect_2_13_11//jar",
    )

    val jmhV = "1.36"

    val dependencies = Vector(
      "org.openjdk.jmh" % "jmh-core" % jmhV,
      "org.openjdk.jmh" % "jmh-generator-bytecode" % jmhV,
      "org.openjdk.jmh" % "jmh-generator-reflection" % jmhV,
      "org.openjdk.jmh" % "jmh-generator-asm" % jmhV,
    )

    MakeTree(dependencies, replacements)
