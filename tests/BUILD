load("@protobuf//bazel:proto_library.bzl", "proto_library")
load("@rules_scala3//deps:scala_deps.bzl", "scala_deps")

filegroup(
    name = "dependencies",
    srcs = ["Dependencies.scala"],
    visibility = ["//visibility:public"],
)

scala_deps(
    name = "scala_deps",
    src = "//:dependencies",
    dependencies = "tests.Dependencies",
)

genrule(
    name = "scalapb_proto",
    srcs = [
        "//3rdparty/jvm/com/thesamet/scalapb:scalapb_runtime",
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
    visibility = ["//visibility:public"],
    deps = [
        "@protobuf//:descriptor_proto",
    ],
)
