load("@rules_proto//proto:defs.bzl", "proto_library")
load("@rules_scala3//rules:scala_proto.bzl", "scala_proto_library")
load("@rules_scala3//rules:scala.bzl", "scala_library")

proto_library(
    name = "grpc_proto",
    srcs = glob(["*.proto"]),
    deps = [
        "//:scalapb",
    ],
)

scala_proto_library(
    name = "grpc_scala_proto",
    scalapb_options = [
        "grpc",
        "no_lenses",
    ],
    deps = [
        ":grpc_proto",
    ],
)

scala_proto_library(
    name = "grpc_scala_proto_web",
    grpc_web = True,
    scalapb_options = [
        "no_lenses",
    ],
    deps = [
        ":grpc_proto",
    ],
)

scala_library(
    name = "grpc",
    srcs = [
        "AuthService.scala",
        ":grpc_scala_proto",
    ],
    deps_unused_whitelist = [
        "@annex_test//:com_google_protobuf_protobuf_java",
    ],
    deps_used_whitelist = [
        "@com_google_protobuf//java/core",
    ],
    scala = "@rules_scala3//scala:zinc_3_1_migration",
    deps = [
        "@annex_test//:com_thesamet_scalapb_scalapb_runtime_3",
        "@annex_test//:com_thesamet_scalapb_scalapb_runtime_grpc_3",
        "@annex_test//:io_grpc_grpc_api",
        "@annex_test//:io_grpc_grpc_stub",
        "@com_google_protobuf//java/core",
    ],
)

scala_library(
    name = "grpc_web",
    srcs = [
        "AuthServiceGrpcWeb.scala",
        ":grpc_scala_proto_web",
    ],
    deps_unused_whitelist = [
        "@annex_test//:com_google_protobuf_protobuf_java",
    ],
    deps_used_whitelist = [
        "@com_google_protobuf//java/core",
    ],
    scala = "@rules_scala3//scala:zinc_3_1_migration",
    scalacopts = [
        "-scalajs",
    ],
    deps = [
        "@annex_test//:com_thesamet_scalapb_grpcweb_scalapb_grpcweb_sjs1_3",
        "@annex_test//:com_thesamet_scalapb_scalapb_runtime_3",
        "@annex_test//:com_thesamet_scalapb_scalapb_runtime_grpc_3",
        "@annex_test//:io_grpc_grpc_api",
        "@annex_test//:io_grpc_grpc_stub",
        "@com_google_protobuf//java/core",
    ],
)
