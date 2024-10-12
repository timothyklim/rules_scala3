package rules_scala3.deps.src

object BazelExt:
  private lazy val jarArtifactCallback = String(getClass.getResourceAsStream("/deps/src/templates/jar_artifact_callback.bzl").readAllBytes())

  def apply(targets: Vector[Target]): String =
    val dependencyLines: String = targets
      .filterNot(_.replacement_label.isDefined)
      .map(t => s"""{"artifact":"${t.coordinates.toString}","url":"${t.url}","name":"${t.name}","actual":"${t.actual}","bind": "${t.bind}"},""")
      .mkString("\n        ")

    s"""# Do not edit. rules_scala3 autogenerates this file
       |$jarArtifactCallback
       |
       |def list_dependencies():
       |    return [
       |        $dependencyLines
       |    ]
       |
       |def maven_dependencies(callback = jar_artifact_callback):
       |    for hash in list_dependencies():
       |        callback(hash)
       |""".stripMargin
