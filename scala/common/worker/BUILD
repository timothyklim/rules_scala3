load("@rules_proto//proto:defs.bzl", "proto_library")
load("//rules:scalafmt.bzl", "scala_format_test")
load("//scala3:defs.bzl", "worker_scala_library")

proto_library(
    name = "worker_protocol_proto",
    srcs = [":worker_protocol.proto"],
)

java_proto_library(
    name = "worker_protocol_java_proto",
    deps = [":worker_protocol_proto"],
)

worker_scala_library(
    name = "worker",
    srcs = ["WorkerMain.scala"],
    visibility = ["//visibility:public"],
    deps = [
        ":worker_protocol_java_proto",
        "//scala/common/worker/agent",
        "//scala/workers/common",
    ],
)

scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)
