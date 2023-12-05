load("//scala3:defs.bzl", "worker_scala_library")
load("//rules:scalafmt.bzl", "scala_format_test")

worker_scala_library(
    name = "worker",
    srcs = glob(["**/*.scala"]),
    visibility = ["//visibility:public"],
    deps = [
        "//scala/workers/common",
        "@bazel_tools//src/main/protobuf:worker_protocol_java_proto",
    ],
)

scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)
