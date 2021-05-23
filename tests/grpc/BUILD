load("@rules_proto//proto:defs.bzl", "proto_library")
load("@rules_scala3//rules:scala_proto.bzl", "scala_proto_library")
load("@rules_scala3//rules:scala.bzl", "scala_library")

proto_library(
    name = "scalapb",
    srcs = ["scalapb/scalapb.proto"],
    strip_import_prefix = "/" + package_name(),
    deps = [
        "@com_google_protobuf//:descriptor_proto",
    ],
)

proto_library(
    name = "grpc_proto",
    srcs = glob(["*.proto"]),
    deps = [
        ":scalapb",
    ],
)

scala_proto_library(
    name = "grpc_scala_proto",
    deps = [
        ":grpc_proto",
    ],
)

scala_library(
    name = "grpc",
    srcs = [":grpc_scala_proto"],
    scala = "@rules_scala3//scala:zinc_3_0_migration",
    deps_unused_whitelist = [
        "@annex_test//:com_google_protobuf_protobuf_java",
    ],
    deps = [
        "@annex_test//:com_thesamet_scalapb_scalapb_runtime_3",
        "@com_google_protobuf//java/core",
    ],
)
