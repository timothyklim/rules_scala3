load("@bazel_tools//tools/jdk:default_java_toolchain.bzl", "default_java_toolchain")
load("@rules_proto//proto:defs.bzl", "proto_library")

genrule(
    name = "scalapb_proto",
    srcs = [
        "@annex_test//:com_thesamet_scalapb_scalapb_runtime_3",
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
    deps = [
        "@com_google_protobuf//:descriptor_proto",
    ],
    visibility = ["//visibility:public"],
)

default_java_toolchain(
    name = "toolchain_hostjdk16",
    configuration = dict(
      tools = ["@remote_java_tools//:javac_jar"],
      jvm_opts = ["-Xbootclasspath/p:$(location @remote_java_tools//:javac_jar)"],
      java_runtime = "@bazel_tools//tools/jdk:jdk",
    ),
    java_runtime = "@bazel_tools//tools/jdk:current_host_java_runtime",
    source_version = "16",
    target_version = "16",
    toolchain_definition = False,
)
