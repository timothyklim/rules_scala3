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
        {"artifact":"com.google.android:annotations:4.1.1.4","url":"https://repo1.maven.org/maven2/com/google/android/annotations/4.1.1.4/annotations-4.1.1.4.jar","name":"com_google_android_annotations","actual":"@com_google_android_annotations//jar","bind": "jar/com/google/android/annotations"},
        {"artifact":"com.google.api.grpc:proto-google-common-protos:2.0.1","url":"https://repo1.maven.org/maven2/com/google/api/grpc/proto-google-common-protos/2.0.1/proto-google-common-protos-2.0.1.jar","name":"com_google_api_grpc_proto_google_common_protos","actual":"@com_google_api_grpc_proto_google_common_protos//jar","bind": "jar/com/google/api/grpc/proto_google_common_protos"},
        {"artifact":"com.google.code.findbugs:jsr305:3.0.2","url":"https://repo1.maven.org/maven2/com/google/code/findbugs/jsr305/3.0.2/jsr305-3.0.2.jar","name":"com_google_code_findbugs_jsr305","actual":"@com_google_code_findbugs_jsr305//jar","bind": "jar/com/google/code/findbugs/jsr305"},
        {"artifact":"com.google.code.gson:gson:2.10.1","url":"https://repo1.maven.org/maven2/com/google/code/gson/gson/2.10.1/gson-2.10.1.jar","name":"com_google_code_gson_gson","actual":"@com_google_code_gson_gson//jar","bind": "jar/com/google/code/gson/gson"},
        {"artifact":"com.google.errorprone:error_prone_annotations:2.18.0","url":"https://repo1.maven.org/maven2/com/google/errorprone/error_prone_annotations/2.18.0/error_prone_annotations-2.18.0.jar","name":"com_google_errorprone_error_prone_annotations","actual":"@com_google_errorprone_error_prone_annotations//jar","bind": "jar/com/google/errorprone/error_prone_annotations"},
        {"artifact":"com.google.guava:failureaccess:1.0.1","url":"https://repo1.maven.org/maven2/com/google/guava/failureaccess/1.0.1/failureaccess-1.0.1.jar","name":"com_google_guava_failureaccess","actual":"@com_google_guava_failureaccess//jar","bind": "jar/com/google/guava/failureaccess"},
        {"artifact":"com.google.guava:guava:32.0.1-android","url":"https://repo1.maven.org/maven2/com/google/guava/guava/32.0.1-android/guava-32.0.1-android.jar","name":"com_google_guava_guava","actual":"@com_google_guava_guava//jar","bind": "jar/com/google/guava/guava"},
        {"artifact":"com.google.guava:listenablefuture:9999.0-empty-to-avoid-conflict-with-guava","url":"https://repo1.maven.org/maven2/com/google/guava/listenablefuture/9999.0-empty-to-avoid-conflict-with-guava/listenablefuture-9999.0-empty-to-avoid-conflict-with-guava.jar","name":"com_google_guava_listenablefuture","actual":"@com_google_guava_listenablefuture//jar","bind": "jar/com/google/guava/listenablefuture"},
        {"artifact":"com.google.j2objc:j2objc-annotations:2.8","url":"https://repo1.maven.org/maven2/com/google/j2objc/j2objc-annotations/2.8/j2objc-annotations-2.8.jar","name":"com_google_j2objc_j2objc_annotations","actual":"@com_google_j2objc_j2objc_annotations//jar","bind": "jar/com/google/j2objc/j2objc_annotations"},
        {"artifact":"com.google.protobuf:protobuf-java:3.19.6","url":"https://repo1.maven.org/maven2/com/google/protobuf/protobuf-java/3.19.6/protobuf-java-3.19.6.jar","name":"com_google_protobuf_protobuf_java","actual":"@com_google_protobuf_protobuf_java//jar","bind": "jar/com/google/protobuf/protobuf_java"},
        {"artifact":"com.novocode:junit-interface:0.11","url":"https://repo1.maven.org/maven2/com/novocode/junit-interface/0.11/junit-interface-0.11.jar","name":"com_novocode_junit_interface","actual":"@com_novocode_junit_interface//jar","bind": "jar/com/novocode/junit_interface"},
        {"artifact":"com.thesamet.scalapb.grpcweb:scalapb-grpcweb_sjs1_3:0.7.0","url":"https://repo1.maven.org/maven2/com/thesamet/scalapb/grpcweb/scalapb-grpcweb_sjs1_3/0.7.0/scalapb-grpcweb_sjs1_3-0.7.0.jar","name":"com_thesamet_scalapb_grpcweb_scalapb_grpcweb_sjs1_3","actual":"@com_thesamet_scalapb_grpcweb_scalapb_grpcweb_sjs1_3//jar","bind": "jar/com/thesamet/scalapb/grpcweb/scalapb_grpcweb_sjs1_3"},
        {"artifact":"com.thesamet.scalapb:lenses_3:0.11.13","url":"https://repo1.maven.org/maven2/com/thesamet/scalapb/lenses_3/0.11.13/lenses_3-0.11.13.jar","name":"com_thesamet_scalapb_lenses_3","actual":"@com_thesamet_scalapb_lenses_3//jar","bind": "jar/com/thesamet/scalapb/lenses_3"},
        {"artifact":"com.thesamet.scalapb:lenses_sjs1_3:0.11.13","url":"https://repo1.maven.org/maven2/com/thesamet/scalapb/lenses_sjs1_3/0.11.13/lenses_sjs1_3-0.11.13.jar","name":"com_thesamet_scalapb_lenses_sjs1_3","actual":"@com_thesamet_scalapb_lenses_sjs1_3//jar","bind": "jar/com/thesamet/scalapb/lenses_sjs1_3"},
        {"artifact":"com.thesamet.scalapb:protobuf-runtime-scala_sjs1_3:0.8.14","url":"https://repo1.maven.org/maven2/com/thesamet/scalapb/protobuf-runtime-scala_sjs1_3/0.8.14/protobuf-runtime-scala_sjs1_3-0.8.14.jar","name":"com_thesamet_scalapb_protobuf_runtime_scala_sjs1_3","actual":"@com_thesamet_scalapb_protobuf_runtime_scala_sjs1_3//jar","bind": "jar/com/thesamet/scalapb/protobuf_runtime_scala_sjs1_3"},
        {"artifact":"com.thesamet.scalapb:scalapb-runtime_3:0.11.13","url":"https://repo1.maven.org/maven2/com/thesamet/scalapb/scalapb-runtime_3/0.11.13/scalapb-runtime_3-0.11.13.jar","name":"com_thesamet_scalapb_scalapb_runtime_3","actual":"@com_thesamet_scalapb_scalapb_runtime_3//jar","bind": "jar/com/thesamet/scalapb/scalapb_runtime_3"},
        {"artifact":"com.thesamet.scalapb:scalapb-runtime-grpc_3:0.11.13","url":"https://repo1.maven.org/maven2/com/thesamet/scalapb/scalapb-runtime-grpc_3/0.11.13/scalapb-runtime-grpc_3-0.11.13.jar","name":"com_thesamet_scalapb_scalapb_runtime_grpc_3","actual":"@com_thesamet_scalapb_scalapb_runtime_grpc_3//jar","bind": "jar/com/thesamet/scalapb/scalapb_runtime_grpc_3"},
        {"artifact":"com.thesamet.scalapb:scalapb-runtime_sjs1_3:0.11.13","url":"https://repo1.maven.org/maven2/com/thesamet/scalapb/scalapb-runtime_sjs1_3/0.11.13/scalapb-runtime_sjs1_3-0.11.13.jar","name":"com_thesamet_scalapb_scalapb_runtime_sjs1_3","actual":"@com_thesamet_scalapb_scalapb_runtime_sjs1_3//jar","bind": "jar/com/thesamet/scalapb/scalapb_runtime_sjs1_3"},
        {"artifact":"io.grpc:grpc-api:1.57.0","url":"https://repo1.maven.org/maven2/io/grpc/grpc-api/1.57.0/grpc-api-1.57.0.jar","name":"io_grpc_grpc_api","actual":"@io_grpc_grpc_api//jar","bind": "jar/io/grpc/grpc_api"},
        {"artifact":"io.grpc:grpc-context:1.57.0","url":"https://repo1.maven.org/maven2/io/grpc/grpc-context/1.57.0/grpc-context-1.57.0.jar","name":"io_grpc_grpc_context","actual":"@io_grpc_grpc_context//jar","bind": "jar/io/grpc/grpc_context"},
        {"artifact":"io.grpc:grpc-core:1.57.0","url":"https://repo1.maven.org/maven2/io/grpc/grpc-core/1.57.0/grpc-core-1.57.0.jar","name":"io_grpc_grpc_core","actual":"@io_grpc_grpc_core//jar","bind": "jar/io/grpc/grpc_core"},
        {"artifact":"io.grpc:grpc-netty:1.57.0","url":"https://repo1.maven.org/maven2/io/grpc/grpc-netty/1.57.0/grpc-netty-1.57.0.jar","name":"io_grpc_grpc_netty","actual":"@io_grpc_grpc_netty//jar","bind": "jar/io/grpc/grpc_netty"},
        {"artifact":"io.grpc:grpc-protobuf:1.47.1","url":"https://repo1.maven.org/maven2/io/grpc/grpc-protobuf/1.47.1/grpc-protobuf-1.47.1.jar","name":"io_grpc_grpc_protobuf","actual":"@io_grpc_grpc_protobuf//jar","bind": "jar/io/grpc/grpc_protobuf"},
        {"artifact":"io.grpc:grpc-protobuf-lite:1.47.1","url":"https://repo1.maven.org/maven2/io/grpc/grpc-protobuf-lite/1.47.1/grpc-protobuf-lite-1.47.1.jar","name":"io_grpc_grpc_protobuf_lite","actual":"@io_grpc_grpc_protobuf_lite//jar","bind": "jar/io/grpc/grpc_protobuf_lite"},
        {"artifact":"io.grpc:grpc-stub:1.47.1","url":"https://repo1.maven.org/maven2/io/grpc/grpc-stub/1.47.1/grpc-stub-1.47.1.jar","name":"io_grpc_grpc_stub","actual":"@io_grpc_grpc_stub//jar","bind": "jar/io/grpc/grpc_stub"},
        {"artifact":"io.netty:netty-buffer:4.1.93.Final","url":"https://repo1.maven.org/maven2/io/netty/netty-buffer/4.1.93.Final/netty-buffer-4.1.93.Final.jar","name":"io_netty_netty_buffer","actual":"@io_netty_netty_buffer//jar","bind": "jar/io/netty/netty_buffer"},
        {"artifact":"io.netty:netty-codec:4.1.93.Final","url":"https://repo1.maven.org/maven2/io/netty/netty-codec/4.1.93.Final/netty-codec-4.1.93.Final.jar","name":"io_netty_netty_codec","actual":"@io_netty_netty_codec//jar","bind": "jar/io/netty/netty_codec"},
        {"artifact":"io.netty:netty-codec-http:4.1.93.Final","url":"https://repo1.maven.org/maven2/io/netty/netty-codec-http/4.1.93.Final/netty-codec-http-4.1.93.Final.jar","name":"io_netty_netty_codec_http","actual":"@io_netty_netty_codec_http//jar","bind": "jar/io/netty/netty_codec_http"},
        {"artifact":"io.netty:netty-codec-http2:4.1.93.Final","url":"https://repo1.maven.org/maven2/io/netty/netty-codec-http2/4.1.93.Final/netty-codec-http2-4.1.93.Final.jar","name":"io_netty_netty_codec_http2","actual":"@io_netty_netty_codec_http2//jar","bind": "jar/io/netty/netty_codec_http2"},
        {"artifact":"io.netty:netty-codec-socks:4.1.93.Final","url":"https://repo1.maven.org/maven2/io/netty/netty-codec-socks/4.1.93.Final/netty-codec-socks-4.1.93.Final.jar","name":"io_netty_netty_codec_socks","actual":"@io_netty_netty_codec_socks//jar","bind": "jar/io/netty/netty_codec_socks"},
        {"artifact":"io.netty:netty-common:4.1.93.Final","url":"https://repo1.maven.org/maven2/io/netty/netty-common/4.1.93.Final/netty-common-4.1.93.Final.jar","name":"io_netty_netty_common","actual":"@io_netty_netty_common//jar","bind": "jar/io/netty/netty_common"},
        {"artifact":"io.netty:netty-handler:4.1.93.Final","url":"https://repo1.maven.org/maven2/io/netty/netty-handler/4.1.93.Final/netty-handler-4.1.93.Final.jar","name":"io_netty_netty_handler","actual":"@io_netty_netty_handler//jar","bind": "jar/io/netty/netty_handler"},
        {"artifact":"io.netty:netty-handler-proxy:4.1.93.Final","url":"https://repo1.maven.org/maven2/io/netty/netty-handler-proxy/4.1.93.Final/netty-handler-proxy-4.1.93.Final.jar","name":"io_netty_netty_handler_proxy","actual":"@io_netty_netty_handler_proxy//jar","bind": "jar/io/netty/netty_handler_proxy"},
        {"artifact":"io.netty:netty-resolver:4.1.93.Final","url":"https://repo1.maven.org/maven2/io/netty/netty-resolver/4.1.93.Final/netty-resolver-4.1.93.Final.jar","name":"io_netty_netty_resolver","actual":"@io_netty_netty_resolver//jar","bind": "jar/io/netty/netty_resolver"},
        {"artifact":"io.netty:netty-transport:4.1.93.Final","url":"https://repo1.maven.org/maven2/io/netty/netty-transport/4.1.93.Final/netty-transport-4.1.93.Final.jar","name":"io_netty_netty_transport","actual":"@io_netty_netty_transport//jar","bind": "jar/io/netty/netty_transport"},
        {"artifact":"io.netty:netty-transport-native-unix-common:4.1.93.Final","url":"https://repo1.maven.org/maven2/io/netty/netty-transport-native-unix-common/4.1.93.Final/netty-transport-native-unix-common-4.1.93.Final.jar","name":"io_netty_netty_transport_native_unix_common","actual":"@io_netty_netty_transport_native_unix_common//jar","bind": "jar/io/netty/netty_transport_native_unix_common"},
        {"artifact":"io.perfmark:perfmark-api:0.26.0","url":"https://repo1.maven.org/maven2/io/perfmark/perfmark-api/0.26.0/perfmark-api-0.26.0.jar","name":"io_perfmark_perfmark_api","actual":"@io_perfmark_perfmark_api//jar","bind": "jar/io/perfmark/perfmark_api"},
        {"artifact":"junit:junit:4.13.2","url":"https://repo1.maven.org/maven2/junit/junit/4.13.2/junit-4.13.2.jar","name":"junit_junit","actual":"@junit_junit//jar","bind": "jar/junit/junit"},
        {"artifact":"org.checkerframework:checker-qual:3.33.0","url":"https://repo1.maven.org/maven2/org/checkerframework/checker-qual/3.33.0/checker-qual-3.33.0.jar","name":"org_checkerframework_checker_qual","actual":"@org_checkerframework_checker_qual//jar","bind": "jar/org/checkerframework/checker_qual"},
        {"artifact":"org.codehaus.mojo:animal-sniffer-annotations:1.23","url":"https://repo1.maven.org/maven2/org/codehaus/mojo/animal-sniffer-annotations/1.23/animal-sniffer-annotations-1.23.jar","name":"org_codehaus_mojo_animal_sniffer_annotations","actual":"@org_codehaus_mojo_animal_sniffer_annotations//jar","bind": "jar/org/codehaus/mojo/animal_sniffer_annotations"},
        {"artifact":"org.hamcrest:hamcrest-core:1.3","url":"https://repo1.maven.org/maven2/org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.jar","name":"org_hamcrest_hamcrest_core","actual":"@org_hamcrest_hamcrest_core//jar","bind": "jar/org/hamcrest/hamcrest_core"},
        {"artifact":"org.scala-js:scalajs-dom_sjs1_3:2.6.0","url":"https://repo1.maven.org/maven2/org/scala-js/scalajs-dom_sjs1_3/2.6.0/scalajs-dom_sjs1_3-2.6.0.jar","name":"org_scala_js_scalajs_dom_sjs1_3","actual":"@org_scala_js_scalajs_dom_sjs1_3//jar","bind": "jar/org/scala_js/scalajs_dom_sjs1_3"},
        {"artifact":"org.scala-js:scalajs-javalib:1.13.1","url":"https://repo1.maven.org/maven2/org/scala-js/scalajs-javalib/1.13.1/scalajs-javalib-1.13.1.jar","name":"org_scala_js_scalajs_javalib","actual":"@org_scala_js_scalajs_javalib//jar","bind": "jar/org/scala_js/scalajs_javalib"},
        {"artifact":"org.scala-js:scalajs-library_2.13:1.13.1","url":"https://repo1.maven.org/maven2/org/scala-js/scalajs-library_2.13/1.13.1/scalajs-library_2.13-1.13.1.jar","name":"org_scala_js_scalajs_library_2_13","actual":"@org_scala_js_scalajs_library_2_13//jar","bind": "jar/org/scala_js/scalajs_library_2_13"},
        {"artifact":"org.scala-lang.modules:scala-collection-compat_3:2.9.0","url":"https://repo1.maven.org/maven2/org/scala-lang/modules/scala-collection-compat_3/2.9.0/scala-collection-compat_3-2.9.0.jar","name":"org_scala_lang_modules_scala_collection_compat_3","actual":"@org_scala_lang_modules_scala_collection_compat_3//jar","bind": "jar/org/scala_lang/modules/scala_collection_compat_3"},
        {"artifact":"org.scala-lang.modules:scala-collection-compat_sjs1_3:2.9.0","url":"https://repo1.maven.org/maven2/org/scala-lang/modules/scala-collection-compat_sjs1_3/2.9.0/scala-collection-compat_sjs1_3-2.9.0.jar","name":"org_scala_lang_modules_scala_collection_compat_sjs1_3","actual":"@org_scala_lang_modules_scala_collection_compat_sjs1_3//jar","bind": "jar/org/scala_lang/modules/scala_collection_compat_sjs1_3"},
        {"artifact":"org.scala-lang.modules:scala-xml_3:2.2.0","url":"https://repo1.maven.org/maven2/org/scala-lang/modules/scala-xml_3/2.2.0/scala-xml_3-2.2.0.jar","name":"org_scala_lang_modules_scala_xml_3","actual":"@org_scala_lang_modules_scala_xml_3//jar","bind": "jar/org/scala_lang/modules/scala_xml_3"},
        {"artifact":"org.scala-lang:scala3-library_sjs1_3:3.3.0","url":"https://repo1.maven.org/maven2/org/scala-lang/scala3-library_sjs1_3/3.3.0/scala3-library_sjs1_3-3.3.0.jar","name":"org_scala_lang_scala3_library_sjs1_3","actual":"@org_scala_lang_scala3_library_sjs1_3//jar","bind": "jar/org/scala_lang/scala3_library_sjs1_3"},
        {"artifact":"org.scala-sbt:compiler-interface:1.9.3","url":"https://repo1.maven.org/maven2/org/scala-sbt/compiler-interface/1.9.3/compiler-interface-1.9.3.jar","name":"org_scala_sbt_compiler_interface","actual":"@org_scala_sbt_compiler_interface//jar","bind": "jar/org/scala_sbt/compiler_interface"},
        {"artifact":"org.scala-sbt:test-interface:1.0","url":"https://repo1.maven.org/maven2/org/scala-sbt/test-interface/1.0/test-interface-1.0.jar","name":"org_scala_sbt_test_interface","actual":"@org_scala_sbt_test_interface//jar","bind": "jar/org/scala_sbt/test_interface"},
        {"artifact":"org.scala-sbt:util-interface:1.9.2","url":"https://repo1.maven.org/maven2/org/scala-sbt/util-interface/1.9.2/util-interface-1.9.2.jar","name":"org_scala_sbt_util_interface","actual":"@org_scala_sbt_util_interface//jar","bind": "jar/org/scala_sbt/util_interface"},
        {"artifact":"org.scalacheck:scalacheck_3:1.17.0","url":"https://repo1.maven.org/maven2/org/scalacheck/scalacheck_3/1.17.0/scalacheck_3-1.17.0.jar","name":"org_scalacheck_scalacheck_3","actual":"@org_scalacheck_scalacheck_3//jar","bind": "jar/org/scalacheck/scalacheck_3"},
        {"artifact":"org.scalameta:junit-interface:1.0.0-M8","url":"https://repo1.maven.org/maven2/org/scalameta/junit-interface/1.0.0-M8/junit-interface-1.0.0-M8.jar","name":"org_scalameta_junit_interface","actual":"@org_scalameta_junit_interface//jar","bind": "jar/org/scalameta/junit_interface"},
        {"artifact":"org.scalameta:munit_3:1.0.0-M8","url":"https://repo1.maven.org/maven2/org/scalameta/munit_3/1.0.0-M8/munit_3-1.0.0-M8.jar","name":"org_scalameta_munit_3","actual":"@org_scalameta_munit_3//jar","bind": "jar/org/scalameta/munit_3"},
        {"artifact":"org.scalameta:munit-scalacheck_3:1.0.0-M8","url":"https://repo1.maven.org/maven2/org/scalameta/munit-scalacheck_3/1.0.0-M8/munit-scalacheck_3-1.0.0-M8.jar","name":"org_scalameta_munit_scalacheck_3","actual":"@org_scalameta_munit_scalacheck_3//jar","bind": "jar/org/scalameta/munit_scalacheck_3"},
    ]

def maven_dependencies(callback = jar_artifact_callback):
    for hash in list_dependencies():
        callback(hash)
