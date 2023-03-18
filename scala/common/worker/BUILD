load("//rules:scalafmt.bzl", "scala_format_test")
load("//rules:scala.bzl", "scala_library")

scala_library(
    name = "worker",
    srcs = glob(["**/*.scala"]),
    scala = "//scala:bootstrap_3_3",
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
