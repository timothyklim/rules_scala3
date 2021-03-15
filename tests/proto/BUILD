load(
    "@rules_scala//rules:scala_proto.bzl",
    "scala_proto_library",
)
load(
    "@rules_scala//rules:scala.bzl",
    "scala_library",
)

proto_library(
    name = "zero_proto",
    srcs = ["zero.proto"],
    visibility = ["//visibility:public"],
)

scala_proto_library(
    name = "zero_scala_proto",
    deps = [":zero_proto"],
)

scala_library(
    name = "zero_scala",
    srcs = [":zero_scala_proto"],
    scala = "//scala:zinc_3_0_0",
    deps = [
        "@annex_test//:com_google_protobuf_protobuf_java",
        "@annex_test//:com_thesamet_scalapb_lenses_3_0_0_RC1",
        "@annex_test//:com_thesamet_scalapb_scalapb_runtime_3_0_0_RC1",
    ],
)
