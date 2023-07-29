# Do not edit. rules_scala3 autogenerates this file
def _jar_artifact_impl(ctx):
    jar_name = "%s.jar" % ctx.name
    ctx.download(
        output = ctx.path("jar/%s" % jar_name),
        url = ctx.attr.urls,
        executable = False
    )
    build_file_contents = """
package(default_visibility = ['//visibility:public'])
filegroup(
    name = 'jar',
    srcs = ['{jar_name}'],
    visibility = ['//visibility:public']
)\n""".format(artifact = ctx.attr.artifact, jar_name = jar_name)
    ctx.file(ctx.path("jar/BUILD"), build_file_contents, False)
    return None

jar_artifact = repository_rule(
    attrs = {
        "artifact": attr.string(mandatory = True),
        "urls": attr.string_list(mandatory = True),
    },
    implementation = _jar_artifact_impl
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
        {"artifact":"com.eed3si9n:gigahorse-core_3:0.6.0","url":"https://repo1.maven.org/maven2/com/eed3si9n/gigahorse-core_3/0.6.0/gigahorse-core_3-0.6.0.jar","name":"com_eed3si9n_gigahorse_core_3","actual":"@com_eed3si9n_gigahorse_core_3//jar","bind": "jar/com/eed3si9n/gigahorse_core_3"},
        {"artifact":"com.eed3si9n:gigahorse-okhttp_3:0.6.0","url":"https://repo1.maven.org/maven2/com/eed3si9n/gigahorse-okhttp_3/0.6.0/gigahorse-okhttp_3-0.6.0.jar","name":"com_eed3si9n_gigahorse_okhttp_3","actual":"@com_eed3si9n_gigahorse_okhttp_3//jar","bind": "jar/com/eed3si9n/gigahorse_okhttp_3"},
        {"artifact":"com.eed3si9n:shaded-jawn-parser_3:1.3.2","url":"https://repo1.maven.org/maven2/com/eed3si9n/shaded-jawn-parser_3/1.3.2/shaded-jawn-parser_3-1.3.2.jar","name":"com_eed3si9n_shaded_jawn_parser_3","actual":"@com_eed3si9n_shaded_jawn_parser_3//jar","bind": "jar/com/eed3si9n/shaded_jawn_parser_3"},
        {"artifact":"com.eed3si9n:shaded-scalajson_3:1.0.0-M4","url":"https://repo1.maven.org/maven2/com/eed3si9n/shaded-scalajson_3/1.0.0-M4/shaded-scalajson_3-1.0.0-M4.jar","name":"com_eed3si9n_shaded_scalajson_3","actual":"@com_eed3si9n_shaded_scalajson_3//jar","bind": "jar/com/eed3si9n/shaded_scalajson_3"},
        {"artifact":"com.eed3si9n:sjson-new-core_3:0.13.0","url":"https://repo1.maven.org/maven2/com/eed3si9n/sjson-new-core_3/0.13.0/sjson-new-core_3-0.13.0.jar","name":"com_eed3si9n_sjson_new_core_3","actual":"@com_eed3si9n_sjson_new_core_3//jar","bind": "jar/com/eed3si9n/sjson_new_core_3"},
        {"artifact":"com.eed3si9n:sjson-new-murmurhash_3:0.13.0","url":"https://repo1.maven.org/maven2/com/eed3si9n/sjson-new-murmurhash_3/0.13.0/sjson-new-murmurhash_3-0.13.0.jar","name":"com_eed3si9n_sjson_new_murmurhash_3","actual":"@com_eed3si9n_sjson_new_murmurhash_3//jar","bind": "jar/com/eed3si9n/sjson_new_murmurhash_3"},
        {"artifact":"com.eed3si9n:sjson-new-scalajson_3:0.13.0","url":"https://repo1.maven.org/maven2/com/eed3si9n/sjson-new-scalajson_3/0.13.0/sjson-new-scalajson_3-0.13.0.jar","name":"com_eed3si9n_sjson_new_scalajson_3","actual":"@com_eed3si9n_sjson_new_scalajson_3//jar","bind": "jar/com/eed3si9n/sjson_new_scalajson_3"},
        {"artifact":"com.jcraft:jsch:0.1.54","url":"https://repo1.maven.org/maven2/com/jcraft/jsch/0.1.54/jsch-0.1.54.jar","name":"com_jcraft_jsch","actual":"@com_jcraft_jsch//jar","bind": "jar/com/jcraft/jsch"},
        {"artifact":"com.lmax:disruptor:3.4.2","url":"https://repo1.maven.org/maven2/com/lmax/disruptor/3.4.2/disruptor-3.4.2.jar","name":"com_lmax_disruptor","actual":"@com_lmax_disruptor//jar","bind": "jar/com/lmax/disruptor"},
        {"artifact":"com.squareup.okhttp3:okhttp:3.14.2","url":"https://repo1.maven.org/maven2/com/squareup/okhttp3/okhttp/3.14.2/okhttp-3.14.2.jar","name":"com_squareup_okhttp3_okhttp","actual":"@com_squareup_okhttp3_okhttp//jar","bind": "jar/com/squareup/okhttp3/okhttp"},
        {"artifact":"com.squareup.okhttp3:okhttp-urlconnection:3.7.0","url":"https://repo1.maven.org/maven2/com/squareup/okhttp3/okhttp-urlconnection/3.7.0/okhttp-urlconnection-3.7.0.jar","name":"com_squareup_okhttp3_okhttp_urlconnection","actual":"@com_squareup_okhttp3_okhttp_urlconnection//jar","bind": "jar/com/squareup/okhttp3/okhttp_urlconnection"},
        {"artifact":"com.squareup.okio:okio:1.17.2","url":"https://repo1.maven.org/maven2/com/squareup/okio/okio/1.17.2/okio-1.17.2.jar","name":"com_squareup_okio_okio","actual":"@com_squareup_okio_okio//jar","bind": "jar/com/squareup/okio/okio"},
        {"artifact":"com.swoval:file-tree-views:2.1.9","url":"https://repo1.maven.org/maven2/com/swoval/file-tree-views/2.1.9/file-tree-views-2.1.9.jar","name":"com_swoval_file_tree_views","actual":"@com_swoval_file_tree_views//jar","bind": "jar/com/swoval/file_tree_views"},
        {"artifact":"com.typesafe:config:1.4.1","url":"https://repo1.maven.org/maven2/com/typesafe/config/1.4.1/config-1.4.1.jar","name":"com_typesafe_config","actual":"@com_typesafe_config//jar","bind": "jar/com/typesafe/config"},
        {"artifact":"com.typesafe:ssl-config-core_3:0.6.0","url":"https://repo1.maven.org/maven2/com/typesafe/ssl-config-core_3/0.6.0/ssl-config-core_3-0.6.0.jar","name":"com_typesafe_ssl_config_core_3","actual":"@com_typesafe_ssl_config_core_3//jar","bind": "jar/com/typesafe/ssl_config_core_3"},
        {"artifact":"net.java.dev.jna:jna:5.12.0","url":"https://repo1.maven.org/maven2/net/java/dev/jna/jna/5.12.0/jna-5.12.0.jar","name":"net_java_dev_jna_jna","actual":"@net_java_dev_jna_jna//jar","bind": "jar/net/java/dev/jna/jna"},
        {"artifact":"net.java.dev.jna:jna-platform:5.12.0","url":"https://repo1.maven.org/maven2/net/java/dev/jna/jna-platform/5.12.0/jna-platform-5.12.0.jar","name":"net_java_dev_jna_jna_platform","actual":"@net_java_dev_jna_jna_platform//jar","bind": "jar/net/java/dev/jna/jna_platform"},
        {"artifact":"org.apache.logging.log4j:log4j-api:2.17.1","url":"https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-api/2.17.1/log4j-api-2.17.1.jar","name":"org_apache_logging_log4j_log4j_api","actual":"@org_apache_logging_log4j_log4j_api//jar","bind": "jar/org/apache/logging/log4j/log4j_api"},
        {"artifact":"org.apache.logging.log4j:log4j-core:2.17.1","url":"https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-core/2.17.1/log4j-core-2.17.1.jar","name":"org_apache_logging_log4j_log4j_core","actual":"@org_apache_logging_log4j_log4j_core//jar","bind": "jar/org/apache/logging/log4j/log4j_core"},
        {"artifact":"org.fusesource.jansi:jansi:2.1.0","url":"https://repo1.maven.org/maven2/org/fusesource/jansi/jansi/2.1.0/jansi-2.1.0.jar","name":"org_fusesource_jansi_jansi","actual":"@org_fusesource_jansi_jansi//jar","bind": "jar/org/fusesource/jansi/jansi"},
        {"artifact":"org.jline:jline-terminal:3.19.0","url":"https://repo1.maven.org/maven2/org/jline/jline-terminal/3.19.0/jline-terminal-3.19.0.jar","name":"org_jline_jline_terminal","actual":"@org_jline_jline_terminal//jar","bind": "jar/org/jline/jline_terminal"},
        {"artifact":"org.jline:jline-terminal-jansi:3.19.0","url":"https://repo1.maven.org/maven2/org/jline/jline-terminal-jansi/3.19.0/jline-terminal-jansi-3.19.0.jar","name":"org_jline_jline_terminal_jansi","actual":"@org_jline_jline_terminal_jansi//jar","bind": "jar/org/jline/jline_terminal_jansi"},
        {"artifact":"org.jline:jline-terminal-jna:3.19.0","url":"https://repo1.maven.org/maven2/org/jline/jline-terminal-jna/3.19.0/jline-terminal-jna-3.19.0.jar","name":"org_jline_jline_terminal_jna","actual":"@org_jline_jline_terminal_jna//jar","bind": "jar/org/jline/jline_terminal_jna"},
        {"artifact":"org.reactivestreams:reactive-streams:1.0.3","url":"https://repo1.maven.org/maven2/org/reactivestreams/reactive-streams/1.0.3/reactive-streams-1.0.3.jar","name":"org_reactivestreams_reactive_streams","actual":"@org_reactivestreams_reactive_streams//jar","bind": "jar/org/reactivestreams/reactive_streams"},
        {"artifact":"org.scala-lang.modules:scala-parallel-collections_3:1.0.4","url":"https://repo1.maven.org/maven2/org/scala-lang/modules/scala-parallel-collections_3/1.0.4/scala-parallel-collections_3-1.0.4.jar","name":"org_scala_lang_modules_scala_parallel_collections_3","actual":"@org_scala_lang_modules_scala_parallel_collections_3//jar","bind": "jar/org/scala_lang/modules/scala_parallel_collections_3"},
        {"artifact":"org.scala-lang.modules:scala-xml_3:2.1.0","url":"https://repo1.maven.org/maven2/org/scala-lang/modules/scala-xml_3/2.1.0/scala-xml_3-2.1.0.jar","name":"org_scala_lang_modules_scala_xml_3","actual":"@org_scala_lang_modules_scala_xml_3//jar","bind": "jar/org/scala_lang/modules/scala_xml_3"},
        {"artifact":"org.scala-sbt:collections_3:2.0.0-alpha5","url":"https://repo1.maven.org/maven2/org/scala-sbt/collections_3/2.0.0-alpha5/collections_3-2.0.0-alpha5.jar","name":"org_scala_sbt_collections_3","actual":"@org_scala_sbt_collections_3//jar","bind": "jar/org/scala_sbt/collections_3"},
        {"artifact":"org.scala-sbt:core-macros_3:2.0.0-alpha5","url":"https://repo1.maven.org/maven2/org/scala-sbt/core-macros_3/2.0.0-alpha5/core-macros_3-2.0.0-alpha5.jar","name":"org_scala_sbt_core_macros_3","actual":"@org_scala_sbt_core_macros_3//jar","bind": "jar/org/scala_sbt/core_macros_3"},
        {"artifact":"org.scala-sbt:io_3:1.7.0","url":"https://repo1.maven.org/maven2/org/scala-sbt/io_3/1.7.0/io_3-1.7.0.jar","name":"org_scala_sbt_io_3","actual":"@org_scala_sbt_io_3//jar","bind": "jar/org/scala_sbt/io_3"},
        {"artifact":"org.scala-sbt.jline:jline:2.14.7-sbt-a1b0ffbb8f64bb820f4f84a0c07a0c0964507493","url":"https://repo1.maven.org/maven2/org/scala-sbt/jline/jline/2.14.7-sbt-a1b0ffbb8f64bb820f4f84a0c07a0c0964507493/jline-2.14.7-sbt-a1b0ffbb8f64bb820f4f84a0c07a0c0964507493.jar","name":"org_scala_sbt_jline_jline","actual":"@org_scala_sbt_jline_jline//jar","bind": "jar/org/scala_sbt/jline/jline"},
        {"artifact":"org.scala-sbt:launcher-interface:1.0.0","url":"https://repo1.maven.org/maven2/org/scala-sbt/launcher-interface/1.0.0/launcher-interface-1.0.0.jar","name":"org_scala_sbt_launcher_interface","actual":"@org_scala_sbt_launcher_interface//jar","bind": "jar/org/scala_sbt/launcher_interface"},
        {"artifact":"org.scala-sbt:librarymanagement-core_3:2.0.0-alpha12","url":"https://repo1.maven.org/maven2/org/scala-sbt/librarymanagement-core_3/2.0.0-alpha12/librarymanagement-core_3-2.0.0-alpha12.jar","name":"org_scala_sbt_librarymanagement_core_3","actual":"@org_scala_sbt_librarymanagement_core_3//jar","bind": "jar/org/scala_sbt/librarymanagement_core_3"},
        {"artifact":"org.scala-sbt:librarymanagement-coursier_3:2.0.0-alpha6","url":"https://repo1.maven.org/maven2/org/scala-sbt/librarymanagement-coursier_3/2.0.0-alpha6/librarymanagement-coursier_3-2.0.0-alpha6.jar","name":"org_scala_sbt_librarymanagement_coursier_3","actual":"@org_scala_sbt_librarymanagement_coursier_3//jar","bind": "jar/org/scala_sbt/librarymanagement_coursier_3"},
        {"artifact":"org.scala-sbt:util-cache_3:2.0.0-alpha5","url":"https://repo1.maven.org/maven2/org/scala-sbt/util-cache_3/2.0.0-alpha5/util-cache_3-2.0.0-alpha5.jar","name":"org_scala_sbt_util_cache_3","actual":"@org_scala_sbt_util_cache_3//jar","bind": "jar/org/scala_sbt/util_cache_3"},
        {"artifact":"org.scala-sbt:util-interface:2.0.0-alpha5","url":"https://repo1.maven.org/maven2/org/scala-sbt/util-interface/2.0.0-alpha5/util-interface-2.0.0-alpha5.jar","name":"org_scala_sbt_util_interface","actual":"@org_scala_sbt_util_interface//jar","bind": "jar/org/scala_sbt/util_interface"},
        {"artifact":"org.scala-sbt:util-logging_3:2.0.0-alpha5","url":"https://repo1.maven.org/maven2/org/scala-sbt/util-logging_3/2.0.0-alpha5/util-logging_3-2.0.0-alpha5.jar","name":"org_scala_sbt_util_logging_3","actual":"@org_scala_sbt_util_logging_3//jar","bind": "jar/org/scala_sbt/util_logging_3"},
        {"artifact":"org.scala-sbt:util-position_3:2.0.0-alpha5","url":"https://repo1.maven.org/maven2/org/scala-sbt/util-position_3/2.0.0-alpha5/util-position_3-2.0.0-alpha5.jar","name":"org_scala_sbt_util_position_3","actual":"@org_scala_sbt_util_position_3//jar","bind": "jar/org/scala_sbt/util_position_3"},
        {"artifact":"org.slf4j:slf4j-api:1.7.28","url":"https://repo1.maven.org/maven2/org/slf4j/slf4j-api/1.7.28/slf4j-api-1.7.28.jar","name":"org_slf4j_slf4j_api","actual":"@org_slf4j_slf4j_api//jar","bind": "jar/org/slf4j/slf4j_api"},
    ]

def maven_dependencies(callback = jar_artifact_callback):
    for hash in list_dependencies():
        callback(hash)
