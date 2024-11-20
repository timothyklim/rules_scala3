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
        {"artifact":"ch.epfl.scala:scalafix-cli_3.5.1:0.13.0","url":"https://repo1.maven.org/maven2/ch/epfl/scala/scalafix-cli_3.5.1/0.13.0/scalafix-cli_3.5.1-0.13.0.jar","name":"ch_epfl_scala_scalafix_cli_3_5_1","actual":"@ch_epfl_scala_scalafix_cli_3_5_1//jar","bind": "jar/ch/epfl/scala/scalafix_cli_3_5_1"},
        {"artifact":"ch.epfl.scala:scalafix-core_2.13:0.13.0","url":"https://repo1.maven.org/maven2/ch/epfl/scala/scalafix-core_2.13/0.13.0/scalafix-core_2.13-0.13.0.jar","name":"ch_epfl_scala_scalafix_core_2_13","actual":"@ch_epfl_scala_scalafix_core_2_13//jar","bind": "jar/ch/epfl/scala/scalafix_core_2_13"},
        {"artifact":"ch.epfl.scala:scalafix-interfaces:0.13.0","url":"https://repo1.maven.org/maven2/ch/epfl/scala/scalafix-interfaces/0.13.0/scalafix-interfaces-0.13.0.jar","name":"ch_epfl_scala_scalafix_interfaces","actual":"@ch_epfl_scala_scalafix_interfaces//jar","bind": "jar/ch/epfl/scala/scalafix_interfaces"},
        {"artifact":"ch.epfl.scala:scalafix-reflect_2.13.15:0.13.0","url":"https://repo1.maven.org/maven2/ch/epfl/scala/scalafix-reflect_2.13.15/0.13.0/scalafix-reflect_2.13.15-0.13.0.jar","name":"ch_epfl_scala_scalafix_reflect_2_13_15","actual":"@ch_epfl_scala_scalafix_reflect_2_13_15//jar","bind": "jar/ch/epfl/scala/scalafix_reflect_2_13_15"},
        {"artifact":"ch.epfl.scala:scalafix-rules_3.5.1:0.13.0","url":"https://repo1.maven.org/maven2/ch/epfl/scala/scalafix-rules_3.5.1/0.13.0/scalafix-rules_3.5.1-0.13.0.jar","name":"ch_epfl_scala_scalafix_rules_3_5_1","actual":"@ch_epfl_scala_scalafix_rules_3_5_1//jar","bind": "jar/ch/epfl/scala/scalafix_rules_3_5_1"},
        {"artifact":"com.google.code.findbugs:jsr305:3.0.2","url":"https://repo1.maven.org/maven2/com/google/code/findbugs/jsr305/3.0.2/jsr305-3.0.2.jar","name":"com_google_code_findbugs_jsr305","actual":"@com_google_code_findbugs_jsr305//jar","bind": "jar/com/google/code/findbugs/jsr305"},
        {"artifact":"com.google.code.gson:gson:2.10.1","url":"https://repo1.maven.org/maven2/com/google/code/gson/gson/2.10.1/gson-2.10.1.jar","name":"com_google_code_gson_gson","actual":"@com_google_code_gson_gson//jar","bind": "jar/com/google/code/gson/gson"},
        {"artifact":"com.google.errorprone:error_prone_annotations:2.3.4","url":"https://repo1.maven.org/maven2/com/google/errorprone/error_prone_annotations/2.3.4/error_prone_annotations-2.3.4.jar","name":"com_google_errorprone_error_prone_annotations","actual":"@com_google_errorprone_error_prone_annotations//jar","bind": "jar/com/google/errorprone/error_prone_annotations"},
        {"artifact":"com.google.guava:failureaccess:1.0.1","url":"https://repo1.maven.org/maven2/com/google/guava/failureaccess/1.0.1/failureaccess-1.0.1.jar","name":"com_google_guava_failureaccess","actual":"@com_google_guava_failureaccess//jar","bind": "jar/com/google/guava/failureaccess"},
        {"artifact":"com.google.guava:guava:30.1-jre","url":"https://repo1.maven.org/maven2/com/google/guava/guava/30.1-jre/guava-30.1-jre.jar","name":"com_google_guava_guava","actual":"@com_google_guava_guava//jar","bind": "jar/com/google/guava/guava"},
        {"artifact":"com.google.guava:listenablefuture:9999.0-empty-to-avoid-conflict-with-guava","url":"https://repo1.maven.org/maven2/com/google/guava/listenablefuture/9999.0-empty-to-avoid-conflict-with-guava/listenablefuture-9999.0-empty-to-avoid-conflict-with-guava.jar","name":"com_google_guava_listenablefuture","actual":"@com_google_guava_listenablefuture//jar","bind": "jar/com/google/guava/listenablefuture"},
        {"artifact":"com.google.j2objc:j2objc-annotations:1.3","url":"https://repo1.maven.org/maven2/com/google/j2objc/j2objc-annotations/1.3/j2objc-annotations-1.3.jar","name":"com_google_j2objc_j2objc_annotations","actual":"@com_google_j2objc_j2objc_annotations//jar","bind": "jar/com/google/j2objc/j2objc_annotations"},
        {"artifact":"com.google.protobuf:protobuf-java:3.19.6","url":"https://repo1.maven.org/maven2/com/google/protobuf/protobuf-java/3.19.6/protobuf-java-3.19.6.jar","name":"com_google_protobuf_protobuf_java","actual":"@com_google_protobuf_protobuf_java//jar","bind": "jar/com/google/protobuf/protobuf_java"},
        {"artifact":"com.googlecode.java-diff-utils:diffutils:1.3.0","url":"https://repo1.maven.org/maven2/com/googlecode/java-diff-utils/diffutils/1.3.0/diffutils-1.3.0.jar","name":"com_googlecode_java_diff_utils_diffutils","actual":"@com_googlecode_java_diff_utils_diffutils//jar","bind": "jar/com/googlecode/java_diff_utils/diffutils"},
        {"artifact":"com.googlecode.javaewah:JavaEWAH:1.1.13","url":"https://repo1.maven.org/maven2/com/googlecode/javaewah/JavaEWAH/1.1.13/JavaEWAH-1.1.13.jar","name":"com_googlecode_javaewah_JavaEWAH","actual":"@com_googlecode_javaewah_JavaEWAH//jar","bind": "jar/com/googlecode/javaewah/JavaEWAH"},
        {"artifact":"com.lihaoyi:fansi_2.13:0.5.0","url":"https://repo1.maven.org/maven2/com/lihaoyi/fansi_2.13/0.5.0/fansi_2.13-0.5.0.jar","name":"com_lihaoyi_fansi_2_13","actual":"@com_lihaoyi_fansi_2_13//jar","bind": "jar/com/lihaoyi/fansi_2_13"},
        {"artifact":"com.lihaoyi:sourcecode_2.13:0.4.2","url":"https://repo1.maven.org/maven2/com/lihaoyi/sourcecode_2.13/0.4.2/sourcecode_2.13-0.4.2.jar","name":"com_lihaoyi_sourcecode_2_13","actual":"@com_lihaoyi_sourcecode_2_13//jar","bind": "jar/com/lihaoyi/sourcecode_2_13"},
        {"artifact":"com.martiansoftware:nailgun-server:0.9.1","url":"https://repo1.maven.org/maven2/com/martiansoftware/nailgun-server/0.9.1/nailgun-server-0.9.1.jar","name":"com_martiansoftware_nailgun_server","actual":"@com_martiansoftware_nailgun_server//jar","bind": "jar/com/martiansoftware/nailgun_server"},
        {"artifact":"com.thesamet.scalapb:lenses_2.13:0.11.15","url":"https://repo1.maven.org/maven2/com/thesamet/scalapb/lenses_2.13/0.11.15/lenses_2.13-0.11.15.jar","name":"com_thesamet_scalapb_lenses_2_13","actual":"@com_thesamet_scalapb_lenses_2_13//jar","bind": "jar/com/thesamet/scalapb/lenses_2_13"},
        {"artifact":"com.thesamet.scalapb:scalapb-runtime_2.13:0.11.15","url":"https://repo1.maven.org/maven2/com/thesamet/scalapb/scalapb-runtime_2.13/0.11.15/scalapb-runtime_2.13-0.11.15.jar","name":"com_thesamet_scalapb_scalapb_runtime_2_13","actual":"@com_thesamet_scalapb_scalapb_runtime_2_13//jar","bind": "jar/com/thesamet/scalapb/scalapb_runtime_2_13"},
        {"artifact":"com.typesafe:config:1.4.3","url":"https://repo1.maven.org/maven2/com/typesafe/config/1.4.3/config-1.4.3.jar","name":"com_typesafe_config","actual":"@com_typesafe_config//jar","bind": "jar/com/typesafe/config"},
        {"artifact":"io.get-coursier:interface:1.0.20","url":"https://repo1.maven.org/maven2/io/get-coursier/interface/1.0.20/interface-1.0.20.jar","name":"io_get_coursier_interface","actual":"@io_get_coursier_interface//jar","bind": "jar/io/get_coursier/interface"},
        {"artifact":"io.github.java-diff-utils:java-diff-utils:4.12","url":"https://repo1.maven.org/maven2/io/github/java-diff-utils/java-diff-utils/4.12/java-diff-utils-4.12.jar","name":"io_github_java_diff_utils_java_diff_utils","actual":"@io_github_java_diff_utils_java_diff_utils//jar","bind": "jar/io/github/java_diff_utils/java_diff_utils"},
        {"artifact":"net.java.dev.jna:jna:5.15.0","url":"https://repo1.maven.org/maven2/net/java/dev/jna/jna/5.15.0/jna-5.15.0.jar","name":"net_java_dev_jna_jna","actual":"@net_java_dev_jna_jna//jar","bind": "jar/net/java/dev/jna/jna"},
        {"artifact":"org.apache.commons:commons-lang3:3.14.0","url":"https://repo1.maven.org/maven2/org/apache/commons/commons-lang3/3.14.0/commons-lang3-3.14.0.jar","name":"org_apache_commons_commons_lang3","actual":"@org_apache_commons_commons_lang3//jar","bind": "jar/org/apache/commons/commons_lang3"},
        {"artifact":"org.apache.commons:commons-text:1.12.0","url":"https://repo1.maven.org/maven2/org/apache/commons/commons-text/1.12.0/commons-text-1.12.0.jar","name":"org_apache_commons_commons_text","actual":"@org_apache_commons_commons_text//jar","bind": "jar/org/apache/commons/commons_text"},
        {"artifact":"org.checkerframework:checker-qual:3.5.0","url":"https://repo1.maven.org/maven2/org/checkerframework/checker-qual/3.5.0/checker-qual-3.5.0.jar","name":"org_checkerframework_checker_qual","actual":"@org_checkerframework_checker_qual//jar","bind": "jar/org/checkerframework/checker_qual"},
        {"artifact":"org.eclipse.jgit:org.eclipse.jgit:5.13.3.202401111512-r","url":"https://repo1.maven.org/maven2/org/eclipse/jgit/org.eclipse.jgit/5.13.3.202401111512-r/org.eclipse.jgit-5.13.3.202401111512-r.jar","name":"org_eclipse_jgit_org_eclipse_jgit","actual":"@org_eclipse_jgit_org_eclipse_jgit//jar","bind": "jar/org/eclipse/jgit/org_eclipse_jgit"},
        {"artifact":"org.eclipse.lsp4j:org.eclipse.lsp4j:0.20.1","url":"https://repo1.maven.org/maven2/org/eclipse/lsp4j/org.eclipse.lsp4j/0.20.1/org.eclipse.lsp4j-0.20.1.jar","name":"org_eclipse_lsp4j_org_eclipse_lsp4j","actual":"@org_eclipse_lsp4j_org_eclipse_lsp4j//jar","bind": "jar/org/eclipse/lsp4j/org_eclipse_lsp4j"},
        {"artifact":"org.eclipse.lsp4j:org.eclipse.lsp4j.generator:0.20.1","url":"https://repo1.maven.org/maven2/org/eclipse/lsp4j/org.eclipse.lsp4j.generator/0.20.1/org.eclipse.lsp4j.generator-0.20.1.jar","name":"org_eclipse_lsp4j_org_eclipse_lsp4j_generator","actual":"@org_eclipse_lsp4j_org_eclipse_lsp4j_generator//jar","bind": "jar/org/eclipse/lsp4j/org_eclipse_lsp4j_generator"},
        {"artifact":"org.eclipse.lsp4j:org.eclipse.lsp4j.jsonrpc:0.20.1","url":"https://repo1.maven.org/maven2/org/eclipse/lsp4j/org.eclipse.lsp4j.jsonrpc/0.20.1/org.eclipse.lsp4j.jsonrpc-0.20.1.jar","name":"org_eclipse_lsp4j_org_eclipse_lsp4j_jsonrpc","actual":"@org_eclipse_lsp4j_org_eclipse_lsp4j_jsonrpc//jar","bind": "jar/org/eclipse/lsp4j/org_eclipse_lsp4j_jsonrpc"},
        {"artifact":"org.eclipse.xtend:org.eclipse.xtend.lib:2.28.0","url":"https://repo1.maven.org/maven2/org/eclipse/xtend/org.eclipse.xtend.lib/2.28.0/org.eclipse.xtend.lib-2.28.0.jar","name":"org_eclipse_xtend_org_eclipse_xtend_lib","actual":"@org_eclipse_xtend_org_eclipse_xtend_lib//jar","bind": "jar/org/eclipse/xtend/org_eclipse_xtend_lib"},
        {"artifact":"org.eclipse.xtend:org.eclipse.xtend.lib.macro:2.28.0","url":"https://repo1.maven.org/maven2/org/eclipse/xtend/org.eclipse.xtend.lib.macro/2.28.0/org.eclipse.xtend.lib.macro-2.28.0.jar","name":"org_eclipse_xtend_org_eclipse_xtend_lib_macro","actual":"@org_eclipse_xtend_org_eclipse_xtend_lib_macro//jar","bind": "jar/org/eclipse/xtend/org_eclipse_xtend_lib_macro"},
        {"artifact":"org.eclipse.xtext:org.eclipse.xtext.xbase.lib:2.28.0","url":"https://repo1.maven.org/maven2/org/eclipse/xtext/org.eclipse.xtext.xbase.lib/2.28.0/org.eclipse.xtext.xbase.lib-2.28.0.jar","name":"org_eclipse_xtext_org_eclipse_xtext_xbase_lib","actual":"@org_eclipse_xtext_org_eclipse_xtext_xbase_lib//jar","bind": "jar/org/eclipse/xtext/org_eclipse_xtext_xbase_lib"},
        {"artifact":"org.jline:jline:3.26.3","url":"https://repo1.maven.org/maven2/org/jline/jline/3.26.3/jline-3.26.3.jar","name":"org_jline_jline","actual":"@org_jline_jline//jar","bind": "jar/org/jline/jline"},
        {"artifact":"org.jline:jline-native:3.27.0","url":"https://repo1.maven.org/maven2/org/jline/jline-native/3.27.0/jline-native-3.27.0.jar","name":"org_jline_jline_native","actual":"@org_jline_jline_native//jar","bind": "jar/org/jline/jline_native"},
        {"artifact":"org.jline:jline-reader:3.27.0","url":"https://repo1.maven.org/maven2/org/jline/jline-reader/3.27.0/jline-reader-3.27.0.jar","name":"org_jline_jline_reader","actual":"@org_jline_jline_reader//jar","bind": "jar/org/jline/jline_reader"},
        {"artifact":"org.jline:jline-terminal:3.27.0","url":"https://repo1.maven.org/maven2/org/jline/jline-terminal/3.27.0/jline-terminal-3.27.0.jar","name":"org_jline_jline_terminal","actual":"@org_jline_jline_terminal//jar","bind": "jar/org/jline/jline_terminal"},
        {"artifact":"org.jline:jline-terminal-jna:3.27.0","url":"https://repo1.maven.org/maven2/org/jline/jline-terminal-jna/3.27.0/jline-terminal-jna-3.27.0.jar","name":"org_jline_jline_terminal_jna","actual":"@org_jline_jline_terminal_jna//jar","bind": "jar/org/jline/jline_terminal_jna"},
        {"artifact":"org.lz4:lz4-java:1.8.0","url":"https://repo1.maven.org/maven2/org/lz4/lz4-java/1.8.0/lz4-java-1.8.0.jar","name":"org_lz4_lz4_java","actual":"@org_lz4_lz4_java//jar","bind": "jar/org/lz4/lz4_java"},
        {"artifact":"org.scala-lang.modules:scala-asm:9.7.0-scala-2","url":"https://repo1.maven.org/maven2/org/scala-lang/modules/scala-asm/9.7.0-scala-2/scala-asm-9.7.0-scala-2.jar","name":"org_scala_lang_modules_scala_asm","actual":"@org_scala_lang_modules_scala_asm//jar","bind": "jar/org/scala_lang/modules/scala_asm"},
        {"artifact":"org.scala-lang.modules:scala-collection-compat_2.13:2.12.0","url":"https://repo1.maven.org/maven2/org/scala-lang/modules/scala-collection-compat_2.13/2.12.0/scala-collection-compat_2.13-2.12.0.jar","name":"org_scala_lang_modules_scala_collection_compat_2_13","actual":"@org_scala_lang_modules_scala_collection_compat_2_13//jar","bind": "jar/org/scala_lang/modules/scala_collection_compat_2_13"},
        {"artifact":"org.scala-lang:scala3-compiler_3:3.6.1","url":"https://repo1.maven.org/maven2/org/scala-lang/scala3-compiler_3/3.6.1/scala3-compiler_3-3.6.1.jar","name":"org_scala_lang_scala3_compiler_3","actual":"@org_scala_lang_scala3_compiler_3//jar","bind": "jar/org/scala_lang/scala3_compiler_3"},
        {"artifact":"org.scala-lang:scala3-interfaces:3.6.1","url":"https://repo1.maven.org/maven2/org/scala-lang/scala3-interfaces/3.6.1/scala3-interfaces-3.6.1.jar","name":"org_scala_lang_scala3_interfaces","actual":"@org_scala_lang_scala3_interfaces//jar","bind": "jar/org/scala_lang/scala3_interfaces"},
        {"artifact":"org.scala-lang:scala3-presentation-compiler_3:3.5.1","url":"https://repo1.maven.org/maven2/org/scala-lang/scala3-presentation-compiler_3/3.5.1/scala3-presentation-compiler_3-3.5.1.jar","name":"org_scala_lang_scala3_presentation_compiler_3","actual":"@org_scala_lang_scala3_presentation_compiler_3//jar","bind": "jar/org/scala_lang/scala3_presentation_compiler_3"},
        {"artifact":"org.scala-lang:scala-compiler:2.13.15","url":"https://repo1.maven.org/maven2/org/scala-lang/scala-compiler/2.13.15/scala-compiler-2.13.15.jar","name":"org_scala_lang_scala_compiler","actual":"@org_scala_lang_scala_compiler//jar","bind": "jar/org/scala_lang/scala_compiler"},
        {"artifact":"org.scala-lang:scalap:2.13.12","url":"https://repo1.maven.org/maven2/org/scala-lang/scalap/2.13.12/scalap-2.13.12.jar","name":"org_scala_lang_scalap","actual":"@org_scala_lang_scalap//jar","bind": "jar/org/scala_lang/scalap"},
        {"artifact":"org.scala-lang:tasty-core_3:3.6.1","url":"https://repo1.maven.org/maven2/org/scala-lang/tasty-core_3/3.6.1/tasty-core_3-3.6.1.jar","name":"org_scala_lang_tasty_core_3","actual":"@org_scala_lang_tasty_core_3//jar","bind": "jar/org/scala_lang/tasty_core_3"},
        {"artifact":"org.scala-sbt:compiler-interface:1.9.6","url":"https://repo1.maven.org/maven2/org/scala-sbt/compiler-interface/1.9.6/compiler-interface-1.9.6.jar","name":"org_scala_sbt_compiler_interface","actual":"@org_scala_sbt_compiler_interface//jar","bind": "jar/org/scala_sbt/compiler_interface"},
        {"artifact":"org.scala-sbt:util-interface:1.9.8","url":"https://repo1.maven.org/maven2/org/scala-sbt/util-interface/1.9.8/util-interface-1.9.8.jar","name":"org_scala_sbt_util_interface","actual":"@org_scala_sbt_util_interface//jar","bind": "jar/org/scala_sbt/util_interface"},
        {"artifact":"org.scalameta:common_2.13:4.10.1","url":"https://repo1.maven.org/maven2/org/scalameta/common_2.13/4.10.1/common_2.13-4.10.1.jar","name":"org_scalameta_common_2_13","actual":"@org_scalameta_common_2_13//jar","bind": "jar/org/scalameta/common_2_13"},
        {"artifact":"org.scalameta:metaconfig-core_2.13:0.13.0","url":"https://repo1.maven.org/maven2/org/scalameta/metaconfig-core_2.13/0.13.0/metaconfig-core_2.13-0.13.0.jar","name":"org_scalameta_metaconfig_core_2_13","actual":"@org_scalameta_metaconfig_core_2_13//jar","bind": "jar/org/scalameta/metaconfig_core_2_13"},
        {"artifact":"org.scalameta:metaconfig-pprint_2.13:0.13.0","url":"https://repo1.maven.org/maven2/org/scalameta/metaconfig-pprint_2.13/0.13.0/metaconfig-pprint_2.13-0.13.0.jar","name":"org_scalameta_metaconfig_pprint_2_13","actual":"@org_scalameta_metaconfig_pprint_2_13//jar","bind": "jar/org/scalameta/metaconfig_pprint_2_13"},
        {"artifact":"org.scalameta:metaconfig-typesafe-config_2.13:0.13.0","url":"https://repo1.maven.org/maven2/org/scalameta/metaconfig-typesafe-config_2.13/0.13.0/metaconfig-typesafe-config_2.13-0.13.0.jar","name":"org_scalameta_metaconfig_typesafe_config_2_13","actual":"@org_scalameta_metaconfig_typesafe_config_2_13//jar","bind": "jar/org/scalameta/metaconfig_typesafe_config_2_13"},
        {"artifact":"org.scalameta:mtags-interfaces:1.3.2","url":"https://repo1.maven.org/maven2/org/scalameta/mtags-interfaces/1.3.2/mtags-interfaces-1.3.2.jar","name":"org_scalameta_mtags_interfaces","actual":"@org_scalameta_mtags_interfaces//jar","bind": "jar/org/scalameta/mtags_interfaces"},
        {"artifact":"org.scalameta:parsers_2.13:4.10.1","url":"https://repo1.maven.org/maven2/org/scalameta/parsers_2.13/4.10.1/parsers_2.13-4.10.1.jar","name":"org_scalameta_parsers_2_13","actual":"@org_scalameta_parsers_2_13//jar","bind": "jar/org/scalameta/parsers_2_13"},
        {"artifact":"org.scalameta:scalameta_2.13:4.10.1","url":"https://repo1.maven.org/maven2/org/scalameta/scalameta_2.13/4.10.1/scalameta_2.13-4.10.1.jar","name":"org_scalameta_scalameta_2_13","actual":"@org_scalameta_scalameta_2_13//jar","bind": "jar/org/scalameta/scalameta_2_13"},
        {"artifact":"org.scalameta:semanticdb-scalac_2.13.15:4.11.2","url":"https://repo1.maven.org/maven2/org/scalameta/semanticdb-scalac_2.13.15/4.11.2/semanticdb-scalac_2.13.15-4.11.2.jar","name":"org_scalameta_semanticdb_scalac_2_13_15","actual":"@org_scalameta_semanticdb_scalac_2_13_15//jar","bind": "jar/org/scalameta/semanticdb_scalac_2_13_15"},
        {"artifact":"org.scalameta:semanticdb-scalac-core_2.13.15:4.10.1","url":"https://repo1.maven.org/maven2/org/scalameta/semanticdb-scalac-core_2.13.15/4.10.1/semanticdb-scalac-core_2.13.15-4.10.1.jar","name":"org_scalameta_semanticdb_scalac_core_2_13_15","actual":"@org_scalameta_semanticdb_scalac_core_2_13_15//jar","bind": "jar/org/scalameta/semanticdb_scalac_core_2_13_15"},
        {"artifact":"org.scalameta:semanticdb-shared_2.13:4.10.1","url":"https://repo1.maven.org/maven2/org/scalameta/semanticdb-shared_2.13/4.10.1/semanticdb-shared_2.13-4.10.1.jar","name":"org_scalameta_semanticdb_shared_2_13","actual":"@org_scalameta_semanticdb_shared_2_13//jar","bind": "jar/org/scalameta/semanticdb_shared_2_13"},
        {"artifact":"org.scalameta:trees_2.13:4.10.1","url":"https://repo1.maven.org/maven2/org/scalameta/trees_2.13/4.10.1/trees_2.13-4.10.1.jar","name":"org_scalameta_trees_2_13","actual":"@org_scalameta_trees_2_13//jar","bind": "jar/org/scalameta/trees_2_13"},
        {"artifact":"org.slf4j:slf4j-api:1.7.36","url":"https://repo1.maven.org/maven2/org/slf4j/slf4j-api/1.7.36/slf4j-api-1.7.36.jar","name":"org_slf4j_slf4j_api","actual":"@org_slf4j_slf4j_api//jar","bind": "jar/org/slf4j/slf4j_api"},
        {"artifact":"org.typelevel:paiges-core_2.13:0.4.4","url":"https://repo1.maven.org/maven2/org/typelevel/paiges-core_2.13/0.4.4/paiges-core_2.13-0.4.4.jar","name":"org_typelevel_paiges_core_2_13","actual":"@org_typelevel_paiges_core_2_13//jar","bind": "jar/org/typelevel/paiges_core_2_13"},
    ]

def maven_dependencies(callback = jar_artifact_callback):
    for hash in list_dependencies():
        callback(hash)
