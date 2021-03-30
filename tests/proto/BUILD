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
        "@annex_test//:com_google_protobuf_protobuf_java",
        "@annex_test//:com_thesamet_scalapb_scalapb_runtime_2_13",
    ],
)

scala_library(
    name = "zero_scala",
    srcs = [":zero_scala_proto"],
    scala = "//scala:zinc_3_0_0",
    deps = [
        "@annex_test//:com_google_protobuf_protobuf_java",
        "@annex_test//:com_thesamet_scalapb_scalapb_runtime_2_13",
    ],
)
