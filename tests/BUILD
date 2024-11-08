#load("@bazel_tools//tools/jdk:default_java_toolchain.bzl", "default_java_toolchain")
load("@rules_proto//proto:defs.bzl", "proto_library")
load("@rules_scala3//deps:scala_deps.bzl", "scala_deps")

filegroup(
    name = "dependencies",
    srcs = ["Dependencies.scala"],
    visibility = ["//visibility:public"],
)

scala_deps(
    name = "scala_deps",
    src = "//:dependencies",
    dependencies = "tests.Dependencies",
)

genrule(
    name = "scalapb_proto",
    srcs = [
        "//3rdparty/jvm/com/thesamet/scalapb:scalapb_runtime",
    ],
    outs = ["scalapb/scalapb.proto"],
    cmd = """
        for src in $(SRCS); do
            unzip -qo $$src scalapb/scalapb.proto -d .
        done
        mv scalapb/scalapb.proto $(OUTS)
    """,
)

proto_library(
    name = "scalapb",
    srcs = ["scalapb/scalapb.proto"],
    strip_import_prefix = "/" + package_name(),
    visibility = ["//visibility:public"],
    deps = [
        "@com_google_protobuf//:descriptor_proto",
    ],
)

#default_java_toolchain(
#    name = "toolchain_hostjdk16",
#    configuration = dict(
#        java_runtime = "@bazel_tools//tools/jdk:jdk",
#        jvm_opts = ["-Xbootclasspath/p:$(location @remote_java_tools//:javac_jar)"],
#        tools = ["@remote_java_tools//:javac_jar"],
#    ),
#    java_runtime = "@bazel_tools//tools/jdk:current_host_java_runtime",
#    source_version = "16",
#    target_version = "16",
#    toolchain_definition = False,
#)
