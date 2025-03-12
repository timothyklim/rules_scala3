load("@rules_proto//proto:defs.bzl", "proto_library")
load("@rules_scala3//rules:scala.bzl", "scala_library")
load("@rules_scala3//rules:scala_proto.bzl", "scala_proto_library")

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
        "//3rdparty/jvm/com/google/protobuf:protobuf_java",
    ],
    deps_used_whitelist = [
        "@protobuf//java/core",
    ],
    scala = "@rules_scala3//scala:zinc_3_migration",
    deps = [
        "//3rdparty/jvm/com/thesamet/scalapb:scalapb_runtime",
        "//3rdparty/jvm/com/thesamet/scalapb:scalapb_runtime_grpc",
        "//3rdparty/jvm/io/grpc:grpc_api",
        "//3rdparty/jvm/io/grpc:grpc_stub",
        "@protobuf//java/core",
    ],
)

scala_library(
    name = "grpc_web",
    srcs = [
        "AuthServiceGrpcWeb.scala",
        ":grpc_scala_proto_web",
    ],
    deps_unused_whitelist = [
        "//3rdparty/jvm/com/google/protobuf:protobuf_java",
    ],
    deps_used_whitelist = [
        "@protobuf//java/core",
    ],
    scala = "@rules_scala3//scala:zinc_3_migration",
    scalacopts = [
        "-scalajs",
    ],
    deps = [
        "//3rdparty/jvm/com/thesamet/scalapb:protobuf_runtime_scala_sjs1",
        "//3rdparty/jvm/com/thesamet/scalapb:scalapb_runtime",
        "//3rdparty/jvm/com/thesamet/scalapb:scalapb_runtime_grpc",
        "//3rdparty/jvm/io/grpc:grpc_api",
        "//3rdparty/jvm/io/grpc:grpc_stub",
        "@protobuf//java/core",
    ],
)
