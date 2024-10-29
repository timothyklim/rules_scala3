package rules_scala3.deps.src

object BazelExt:
  private val jarArtifactCallback =
    "def _jar_artifact_impl(ctx):\n" +
      "    jar_name = \"%s.jar\" % ctx.name\n" +
      "    ctx.download(\n" +
      "        output = ctx.path(\"jar/%s\" % jar_name),\n" +
      "        url = ctx.attr.urls,\n" +
      "        executable = False,\n" +
      "    )\n" +
      "    build_file_contents = \"\"\"\n" +
      "package(default_visibility = ['//visibility:public'])\n" +
      "filegroup(\n" +
      "    name = 'jar',\n" +
      "    srcs = ['{jar_name}'],\n" +
      "    visibility = ['//visibility:public'],\n" +
      ")\n" +
      "alias(\n" +
      "    name = \"file\",\n" +
      "    actual = \":jar\",\n" +
      "    visibility = [\"//visibility:public\"],\n" +
      ")\\n\"\"\".format(artifact = ctx.attr.artifact, jar_name = jar_name)\n" +
      "    ctx.file(ctx.path(\"jar/BUILD\"), build_file_contents, False)\n" +
      "    return None\n" +
      "\n" +
      "jar_artifact = repository_rule(\n" +
      "    attrs = {\n" +
      "        \"artifact\": attr.string(mandatory = True),\n" +
      "        \"urls\": attr.string_list(mandatory = True),\n" +
      "    },\n" +
      "    implementation = _jar_artifact_impl,\n" +
      ")\n" +
      "\n" +
      "def jar_artifact_callback(hash):\n" +
      "    jar_artifact(\n" +
      "        artifact = hash[\"artifact\"],\n" +
      "        name = hash[\"name\"],\n" +
      "        urls = [hash[\"url\"]],\n" +
      "    )\n" +
      "    native.bind(name = hash[\"bind\"], actual = hash[\"actual\"])"

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
