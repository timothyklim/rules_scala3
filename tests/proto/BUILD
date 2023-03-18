load("@rules_proto//proto:defs.bzl", "proto_library")
load("@rules_scala3//rules:scala_proto.bzl", "scala_proto_library")
load("@rules_scala3//rules:scala.bzl", "scala_library")

proto_library(
    name = "events_proto",
    srcs = glob(["**/*.proto"]),
    deps = [
        "//:scalapb",
    ],
)

scala_proto_library(
    name = "events_scala_proto",
    deps = [
        ":events_proto",
    ],
)

scala_library(
    name = "events_scala",
    srcs = [":events_scala_proto"],
    deps_unused_whitelist = [
        "@annex_test//:com_google_protobuf_protobuf_java",
    ],
    scala = "@rules_scala3//scala:zinc_3_3_migration",
    deps = [
        "@annex_test//:com_thesamet_scalapb_scalapb_runtime_3",
    ],
)
