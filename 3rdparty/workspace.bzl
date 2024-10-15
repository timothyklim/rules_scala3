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
        {"artifact":"com.github.scopt:scopt_3:4.1.0","url":"https://repo1.maven.org/maven2/com/github/scopt/scopt_3/4.1.0/scopt_3-4.1.0.jar","name":"com_github_scopt_scopt_3","actual":"@com_github_scopt_scopt_3//jar","bind": "jar/com/github/scopt/scopt_3"},
        {"artifact":"com.google.protobuf:protobuf-java:4.28.2","url":"https://repo1.maven.org/maven2/com/google/protobuf/protobuf-java/4.28.2/protobuf-java-4.28.2.jar","name":"com_google_protobuf_protobuf_java","actual":"@com_google_protobuf_protobuf_java//jar","bind": "jar/com/google/protobuf/protobuf_java"},
        {"artifact":"com.thesamet.scalapb:compilerplugin_3:1.0.0-alpha.1","url":"https://repo1.maven.org/maven2/com/thesamet/scalapb/compilerplugin_3/1.0.0-alpha.1/compilerplugin_3-1.0.0-alpha.1.jar","name":"com_thesamet_scalapb_compilerplugin_3","actual":"@com_thesamet_scalapb_compilerplugin_3//jar","bind": "jar/com/thesamet/scalapb/compilerplugin_3"},
        {"artifact":"com.thesamet.scalapb.grpcweb:scalapb-grpcweb-code-gen_3:0.7.0","url":"https://repo1.maven.org/maven2/com/thesamet/scalapb/grpcweb/scalapb-grpcweb-code-gen_3/0.7.0/scalapb-grpcweb-code-gen_3-0.7.0.jar","name":"com_thesamet_scalapb_grpcweb_scalapb_grpcweb_code_gen_3","actual":"@com_thesamet_scalapb_grpcweb_scalapb_grpcweb_code_gen_3//jar","bind": "jar/com/thesamet/scalapb/grpcweb/scalapb_grpcweb_code_gen_3"},
        {"artifact":"com.thesamet.scalapb:protoc-bridge_2.13:0.9.7","url":"https://repo1.maven.org/maven2/com/thesamet/scalapb/protoc-bridge_2.13/0.9.7/protoc-bridge_2.13-0.9.7.jar","name":"com_thesamet_scalapb_protoc_bridge_2_13","actual":"@com_thesamet_scalapb_protoc_bridge_2_13//jar","bind": "jar/com/thesamet/scalapb/protoc_bridge_2_13"},
        {"artifact":"com.thesamet.scalapb:protoc-gen_2.13:0.9.7","url":"https://repo1.maven.org/maven2/com/thesamet/scalapb/protoc-gen_2.13/0.9.7/protoc-gen_2.13-0.9.7.jar","name":"com_thesamet_scalapb_protoc_gen_2_13","actual":"@com_thesamet_scalapb_protoc_gen_2_13//jar","bind": "jar/com/thesamet/scalapb/protoc_gen_2_13"},
        {"artifact":"dev.dirs:directories:26","url":"https://repo1.maven.org/maven2/dev/dirs/directories/26/directories-26.jar","name":"dev_dirs_directories","actual":"@dev_dirs_directories//jar","bind": "jar/dev/dirs/directories"},
        {"artifact":"net.sf.jopt-simple:jopt-simple:5.0.4","url":"https://repo1.maven.org/maven2/net/sf/jopt-simple/jopt-simple/5.0.4/jopt-simple-5.0.4.jar","name":"net_sf_jopt_simple_jopt_simple","actual":"@net_sf_jopt_simple_jopt_simple//jar","bind": "jar/net/sf/jopt_simple/jopt_simple"},
        {"artifact":"org.apache.commons:commons-math3:3.6.1","url":"https://repo1.maven.org/maven2/org/apache/commons/commons-math3/3.6.1/commons-math3-3.6.1.jar","name":"org_apache_commons_commons_math3","actual":"@org_apache_commons_commons_math3//jar","bind": "jar/org/apache/commons/commons_math3"},
        {"artifact":"org.openjdk.jmh:jmh-core:1.37","url":"https://repo1.maven.org/maven2/org/openjdk/jmh/jmh-core/1.37/jmh-core-1.37.jar","name":"org_openjdk_jmh_jmh_core","actual":"@org_openjdk_jmh_jmh_core//jar","bind": "jar/org/openjdk/jmh/jmh_core"},
        {"artifact":"org.openjdk.jmh:jmh-generator-asm:1.37","url":"https://repo1.maven.org/maven2/org/openjdk/jmh/jmh-generator-asm/1.37/jmh-generator-asm-1.37.jar","name":"org_openjdk_jmh_jmh_generator_asm","actual":"@org_openjdk_jmh_jmh_generator_asm//jar","bind": "jar/org/openjdk/jmh/jmh_generator_asm"},
        {"artifact":"org.openjdk.jmh:jmh-generator-bytecode:1.37","url":"https://repo1.maven.org/maven2/org/openjdk/jmh/jmh-generator-bytecode/1.37/jmh-generator-bytecode-1.37.jar","name":"org_openjdk_jmh_jmh_generator_bytecode","actual":"@org_openjdk_jmh_jmh_generator_bytecode//jar","bind": "jar/org/openjdk/jmh/jmh_generator_bytecode"},
        {"artifact":"org.openjdk.jmh:jmh-generator-reflection:1.37","url":"https://repo1.maven.org/maven2/org/openjdk/jmh/jmh-generator-reflection/1.37/jmh-generator-reflection-1.37.jar","name":"org_openjdk_jmh_jmh_generator_reflection","actual":"@org_openjdk_jmh_jmh_generator_reflection//jar","bind": "jar/org/openjdk/jmh/jmh_generator_reflection"},
        {"artifact":"org.ow2.asm:asm:9.0","url":"https://repo1.maven.org/maven2/org/ow2/asm/asm/9.0/asm-9.0.jar","name":"org_ow2_asm_asm","actual":"@org_ow2_asm_asm//jar","bind": "jar/org/ow2/asm/asm"},
        {"artifact":"org.scala-lang.modules:scala-collection-compat_3:2.12.0","url":"https://repo1.maven.org/maven2/org/scala-lang/modules/scala-collection-compat_3/2.12.0/scala-collection-compat_3-2.12.0.jar","name":"org_scala_lang_modules_scala_collection_compat_3","actual":"@org_scala_lang_modules_scala_collection_compat_3//jar","bind": "jar/org/scala_lang/modules/scala_collection_compat_3"},
    ]

def maven_dependencies(callback = jar_artifact_callback):
    for hash in list_dependencies():
        callback(hash)
