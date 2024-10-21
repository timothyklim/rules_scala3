# Do not edit. rules_scala3 autogenerates this file
def _jar_artifact_impl(ctx):
    jar_name = "%s.jar" % ctx.name
    ctx.download(
        output = ctx.path("jar/%s" % jar_name),
        url = ctx.attr.urls,
        executable = False,
    )
    build_file_contents = """
package(default_visibility = ['//visibility:public'])
filegroup(
    name = 'jar',
    srcs = ['{jar_name}'],
    visibility = ['//visibility:public'],
)
alias(
    name = "file",
    actual = ":jar",
    visibility = ["//visibility:public"],
)\n""".format(artifact = ctx.attr.artifact, jar_name = jar_name)
    ctx.file(ctx.path("jar/BUILD"), build_file_contents, False)
    return None

jar_artifact = repository_rule(
    attrs = {
        "artifact": attr.string(mandatory = True),
        "urls": attr.string_list(mandatory = True),
    },
    implementation = _jar_artifact_impl,
)

def jar_artifact_callback(hash):
    jar_artifact(
        artifact = hash["artifact"],
        name = hash["name"],
        urls = [hash["url"]],
    )
    native.bind(name = hash["bind"], actual = hash["actual"])


def list_dependencies():
    return [
        {"artifact":"com.geirsson:metaconfig-core_2.13:0.12.0","url":"https://repo1.maven.org/maven2/com/geirsson/metaconfig-core_2.13/0.12.0/metaconfig-core_2.13-0.12.0.jar","name":"com_geirsson_metaconfig_core_2_13","actual":"@com_geirsson_metaconfig_core_2_13//jar","bind": "jar/com/geirsson/metaconfig_core_2_13"},
        {"artifact":"com.geirsson:metaconfig-pprint_2.13:0.12.0","url":"https://repo1.maven.org/maven2/com/geirsson/metaconfig-pprint_2.13/0.12.0/metaconfig-pprint_2.13-0.12.0.jar","name":"com_geirsson_metaconfig_pprint_2_13","actual":"@com_geirsson_metaconfig_pprint_2_13//jar","bind": "jar/com/geirsson/metaconfig_pprint_2_13"},
        {"artifact":"com.geirsson:metaconfig-typesafe-config_2.13:0.12.0","url":"https://repo1.maven.org/maven2/com/geirsson/metaconfig-typesafe-config_2.13/0.12.0/metaconfig-typesafe-config_2.13-0.12.0.jar","name":"com_geirsson_metaconfig_typesafe_config_2_13","actual":"@com_geirsson_metaconfig_typesafe_config_2_13//jar","bind": "jar/com/geirsson/metaconfig_typesafe_config_2_13"},
        {"artifact":"com.lihaoyi:fansi_2.13:0.4.0","url":"https://repo1.maven.org/maven2/com/lihaoyi/fansi_2.13/0.4.0/fansi_2.13-0.4.0.jar","name":"com_lihaoyi_fansi_2_13","actual":"@com_lihaoyi_fansi_2_13//jar","bind": "jar/com/lihaoyi/fansi_2_13"},
        {"artifact":"com.lihaoyi:sourcecode_2.13:0.4.2","url":"https://repo1.maven.org/maven2/com/lihaoyi/sourcecode_2.13/0.4.2/sourcecode_2.13-0.4.2.jar","name":"com_lihaoyi_sourcecode_2_13","actual":"@com_lihaoyi_sourcecode_2_13//jar","bind": "jar/com/lihaoyi/sourcecode_2_13"},
        {"artifact":"com.typesafe:config:1.4.1","url":"https://repo1.maven.org/maven2/com/typesafe/config/1.4.1/config-1.4.1.jar","name":"com_typesafe_config","actual":"@com_typesafe_config//jar","bind": "jar/com/typesafe/config"},
        {"artifact":"io.github.java-diff-utils:java-diff-utils:4.12","url":"https://repo1.maven.org/maven2/io/github/java-diff-utils/java-diff-utils/4.12/java-diff-utils-4.12.jar","name":"io_github_java_diff_utils_java_diff_utils","actual":"@io_github_java_diff_utils_java_diff_utils//jar","bind": "jar/io/github/java_diff_utils/java_diff_utils"},
        {"artifact":"net.java.dev.jna:jna:5.13.0","url":"https://repo1.maven.org/maven2/net/java/dev/jna/jna/5.13.0/jna-5.13.0.jar","name":"net_java_dev_jna_jna","actual":"@net_java_dev_jna_jna//jar","bind": "jar/net/java/dev/jna/jna"},
        {"artifact":"org.jline:jline:3.22.0","url":"https://repo1.maven.org/maven2/org/jline/jline/3.22.0/jline-3.22.0.jar","name":"org_jline_jline","actual":"@org_jline_jline//jar","bind": "jar/org/jline/jline"},
        {"artifact":"org.scala-lang.modules:scala-collection-compat_2.13:2.11.0","url":"https://repo1.maven.org/maven2/org/scala-lang/modules/scala-collection-compat_2.13/2.11.0/scala-collection-compat_2.13-2.11.0.jar","name":"org_scala_lang_modules_scala_collection_compat_2_13","actual":"@org_scala_lang_modules_scala_collection_compat_2_13//jar","bind": "jar/org/scala_lang/modules/scala_collection_compat_2_13"},
        {"artifact":"org.scala-lang.modules:scala-parallel-collections_2.13:1.0.4","url":"https://repo1.maven.org/maven2/org/scala-lang/modules/scala-parallel-collections_2.13/1.0.4/scala-parallel-collections_2.13-1.0.4.jar","name":"org_scala_lang_modules_scala_parallel_collections_2_13","actual":"@org_scala_lang_modules_scala_parallel_collections_2_13//jar","bind": "jar/org/scala_lang/modules/scala_parallel_collections_2_13"},
        {"artifact":"org.scala-lang:scala-compiler:2.13.11","url":"https://repo1.maven.org/maven2/org/scala-lang/scala-compiler/2.13.11/scala-compiler-2.13.11.jar","name":"org_scala_lang_scala_compiler","actual":"@org_scala_lang_scala_compiler//jar","bind": "jar/org/scala_lang/scala_compiler"},
        {"artifact":"org.scala-lang:scala-compiler:2.13.11","url":"https://repo1.maven.org/maven2/org/scala-lang/scala-compiler/2.13.11/scala-compiler-2.13.11.jar","name":"org_scala_lang_scala_compiler","actual":"@org_scala_lang_scala_compiler//jar","bind": "jar/org/scala_lang/scala_compiler"},
        {"artifact":"org.scala-lang:scalap:2.13.11","url":"https://repo1.maven.org/maven2/org/scala-lang/scalap/2.13.11/scalap-2.13.11.jar","name":"org_scala_lang_scalap","actual":"@org_scala_lang_scalap//jar","bind": "jar/org/scala_lang/scalap"},
        {"artifact":"org.scalameta:common_2.13:4.10.2","url":"https://repo1.maven.org/maven2/org/scalameta/common_2.13/4.10.2/common_2.13-4.10.2.jar","name":"org_scalameta_common_2_13","actual":"@org_scalameta_common_2_13//jar","bind": "jar/org/scalameta/common_2_13"},
        {"artifact":"org.scalameta:mdoc-parser_2.13:2.5.4","url":"https://repo1.maven.org/maven2/org/scalameta/mdoc-parser_2.13/2.5.4/mdoc-parser_2.13-2.5.4.jar","name":"org_scalameta_mdoc_parser_2_13","actual":"@org_scalameta_mdoc_parser_2_13//jar","bind": "jar/org/scalameta/mdoc_parser_2_13"},
        {"artifact":"org.scalameta:parsers_2.13:4.10.2","url":"https://repo1.maven.org/maven2/org/scalameta/parsers_2.13/4.10.2/parsers_2.13-4.10.2.jar","name":"org_scalameta_parsers_2_13","actual":"@org_scalameta_parsers_2_13//jar","bind": "jar/org/scalameta/parsers_2_13"},
        {"artifact":"org.scalameta:scalafmt-config_2.13:3.8.3","url":"https://repo1.maven.org/maven2/org/scalameta/scalafmt-config_2.13/3.8.3/scalafmt-config_2.13-3.8.3.jar","name":"org_scalameta_scalafmt_config_2_13","actual":"@org_scalameta_scalafmt_config_2_13//jar","bind": "jar/org/scalameta/scalafmt_config_2_13"},
        {"artifact":"org.scalameta:scalafmt-core_2.13:3.8.3","url":"https://repo1.maven.org/maven2/org/scalameta/scalafmt-core_2.13/3.8.3/scalafmt-core_2.13-3.8.3.jar","name":"org_scalameta_scalafmt_core_2_13","actual":"@org_scalameta_scalafmt_core_2_13//jar","bind": "jar/org/scalameta/scalafmt_core_2_13"},
        {"artifact":"org.scalameta:scalafmt-sysops_2.13:3.8.3","url":"https://repo1.maven.org/maven2/org/scalameta/scalafmt-sysops_2.13/3.8.3/scalafmt-sysops_2.13-3.8.3.jar","name":"org_scalameta_scalafmt_sysops_2_13","actual":"@org_scalameta_scalafmt_sysops_2_13//jar","bind": "jar/org/scalameta/scalafmt_sysops_2_13"},
        {"artifact":"org.scalameta:scalameta_2.13:4.9.9","url":"https://repo1.maven.org/maven2/org/scalameta/scalameta_2.13/4.9.9/scalameta_2.13-4.9.9.jar","name":"org_scalameta_scalameta_2_13","actual":"@org_scalameta_scalameta_2_13//jar","bind": "jar/org/scalameta/scalameta_2_13"},
        {"artifact":"org.scalameta:trees_2.13:4.10.2","url":"https://repo1.maven.org/maven2/org/scalameta/trees_2.13/4.10.2/trees_2.13-4.10.2.jar","name":"org_scalameta_trees_2_13","actual":"@org_scalameta_trees_2_13//jar","bind": "jar/org/scalameta/trees_2_13"},
        {"artifact":"org.typelevel:paiges-core_2.13:0.4.3","url":"https://repo1.maven.org/maven2/org/typelevel/paiges-core_2.13/0.4.3/paiges-core_2.13-0.4.3.jar","name":"org_typelevel_paiges_core_2_13","actual":"@org_typelevel_paiges_core_2_13//jar","bind": "jar/org/typelevel/paiges_core_2_13"},
    ]

def maven_dependencies(callback = jar_artifact_callback):
    for hash in list_dependencies():
        callback(hash)
