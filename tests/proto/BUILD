load("@rules_proto//proto:defs.bzl", "proto_library")
load("@rules_scala3//rules:scala_proto.bzl", "scala_proto_library")
load("@rules_scala3//rules:scala.bzl", "scala_library")

proto_library(
    name = "zero_proto",
    srcs = ["zero.proto"],
    visibility = ["//visibility:public"],
)

scala_proto_library(
    name = "zero_scala_proto",
    deps = [
        ":zero_proto",
        "@annex_test//:com_thesamet_scalapb_scalapb_runtime_3",
        "@com_google_protobuf//:descriptor_proto",
    ],
)

scala_library(
    name = "zero_scala",
    srcs = [":zero_scala_proto"],
    deps_used_whitelist = [
        "@com_google_protobuf//java/core",
    ],
    deps_unused_whitelist = [
        "@annex_test//:com_google_protobuf_protobuf_java",
    ],
    deps = [
        "@annex_test//:com_thesamet_scalapb_scalapb_runtime_3",
        "@com_google_protobuf//java/core",
    ],
)
