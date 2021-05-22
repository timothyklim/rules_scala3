load("@rules_proto//proto:defs.bzl", "proto_library")
load("@rules_scala3//rules:scala_proto.bzl", "scala_proto_library")
load("@rules_scala3//rules:scala.bzl", "scala_library")

genrule(
    name = "scalapb_proto",
    srcs = [
        "@annex_test//:com_thesamet_scalapb_scalapb_runtime_3",
    ],
    outs = ["scalapb/scalapb.proto"],
    cmd = """
        for src in $(SRCS); do
            unzip -qo $$src scalapb/scalapb.proto -d .
        done
        mv scalapb/scalapb.proto $(OUTS)
    """,
)

proto_library(
    name = "scalapb",
    srcs = ["scalapb/scalapb.proto"],
    strip_import_prefix = "/" + package_name(),
    deps = [
        "@com_google_protobuf//:descriptor_proto",
    ],
)

proto_library(
    name = "events_proto",
    srcs = glob(["*.proto"]),
    deps = [
        ":scalapb",
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
    scala = "@rules_scala3//scala:zinc_3_0_migration",
    deps_unused_whitelist = [
        "@annex_test//:com_google_protobuf_protobuf_java",
    ],
    deps = [
        "@annex_test//:com_thesamet_scalapb_scalapb_runtime_3",
        "@com_google_protobuf//java/core",
    ],
)
