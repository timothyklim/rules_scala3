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
        {"artifact":"com.google.protobuf:protobuf-java:4.28.2","url":"https://oss.sonatype.org/service/local/repositories/releases/content/com/google/protobuf/protobuf-java/4.28.2/protobuf-java-4.28.2.jar","name":"com_google_protobuf_protobuf_java","actual":"@protobuf_protobuf_java//jar","bind": "jar/com/google/protobuf/protobuf_java"},
        {"artifact":"com.thesamet.scalapb:compilerplugin_3:1.0.0-alpha.1","url":"https://oss.sonatype.org/service/local/repositories/releases/content/com/thesamet/scalapb/compilerplugin_3/1.0.0-alpha.1/compilerplugin_3-1.0.0-alpha.1.jar","name":"com_thesamet_scalapb_compilerplugin_3","actual":"@com_thesamet_scalapb_compilerplugin_3//jar","bind": "jar/com/thesamet/scalapb/compilerplugin_3"},
        {"artifact":"com.thesamet.scalapb.grpcweb:scalapb-grpcweb-code-gen_3:0.7.0","url":"https://oss.sonatype.org/service/local/repositories/releases/content/com/thesamet/scalapb/grpcweb/scalapb-grpcweb-code-gen_3/0.7.0/scalapb-grpcweb-code-gen_3-0.7.0.jar","name":"com_thesamet_scalapb_grpcweb_scalapb_grpcweb_code_gen_3","actual":"@com_thesamet_scalapb_grpcweb_scalapb_grpcweb_code_gen_3//jar","bind": "jar/com/thesamet/scalapb/grpcweb/scalapb_grpcweb_code_gen_3"},
        {"artifact":"com.thesamet.scalapb:protoc-bridge_2.13:0.9.7","url":"https://oss.sonatype.org/service/local/repositories/releases/content/com/thesamet/scalapb/protoc-bridge_2.13/0.9.7/protoc-bridge_2.13-0.9.7.jar","name":"com_thesamet_scalapb_protoc_bridge_2_13","actual":"@com_thesamet_scalapb_protoc_bridge_2_13//jar","bind": "jar/com/thesamet/scalapb/protoc_bridge_2_13"},
        {"artifact":"com.thesamet.scalapb:protoc-gen_2.13:0.9.7","url":"https://oss.sonatype.org/service/local/repositories/releases/content/com/thesamet/scalapb/protoc-gen_2.13/0.9.7/protoc-gen_2.13-0.9.7.jar","name":"com_thesamet_scalapb_protoc_gen_2_13","actual":"@com_thesamet_scalapb_protoc_gen_2_13//jar","bind": "jar/com/thesamet/scalapb/protoc_gen_2_13"},
        {"artifact":"dev.dirs:directories:26","url":"https://oss.sonatype.org/service/local/repositories/releases/content/dev/dirs/directories/26/directories-26.jar","name":"dev_dirs_directories","actual":"@dev_dirs_directories//jar","bind": "jar/dev/dirs/directories"},
        {"artifact":"org.scala-lang.modules:scala-collection-compat_3:2.12.0","url":"https://oss.sonatype.org/service/local/repositories/releases/content/org/scala-lang/modules/scala-collection-compat_3/2.12.0/scala-collection-compat_3-2.12.0.jar","name":"org_scala_lang_modules_scala_collection_compat_3","actual":"@org_scala_lang_modules_scala_collection_compat_3//jar","bind": "jar/org/scala_lang/modules/scala_collection_compat_3"},
    ]

def maven_dependencies(callback = jar_artifact_callback):
    for hash in list_dependencies():
        callback(hash)
