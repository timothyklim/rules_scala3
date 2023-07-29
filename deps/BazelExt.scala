package rules_scala3.deps

import scala.io.Source
import java.io.FileNotFoundException

object BazelExt:
  private def loadResourceToString(path: String): String =
    val resourceStream = getClass.getResourceAsStream(path)
    if resourceStream == null then throw new FileNotFoundException(s"Resource not found: $path")
    try Source.fromInputStream(resourceStream).mkString finally resourceStream.close

  private lazy val jarArtifactCallback = loadResourceToString("/templates/jar_artifact_callback.bzl")

  def apply(targets: Vector[Target]): String =
    val dependencyLines: String = targets
      .filterNot(_.replacement_label.isDefined)
      .map { t =>
        Vector(
          s"""    {"artifact": "${t.coordinates.toString}"""",
          s""""url": "${t.url}"""",
          s""""name": "${t.name}"""",
          s""""actual": "${t.actual}"""",
          s""""bind": "${t.bind}"},"""
        ).mkString(", ")
      }
      .mkString("\n")

    s"""# Do not edit. rules_scala3 autogenerates this file
       |$jarArtifactCallback
       |
       |def list_dependencies():
       |    return [
       |$dependencyLines
       |    ]
       |
       |def maven_dependencies(callback = jar_artifact_callback):
       |    for hash in list_dependencies():
       |        callback(hash)
       |""".stripMargin
