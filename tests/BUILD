load("@rules_proto//proto:defs.bzl", "proto_library")
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
        "@com_google_protobuf//:descriptor_proto",
    ],
)

java_runtime(
    name = "jdk",
    srcs = select({
        "@bazel_tools//src/conditions:linux_x86_64": ["@jdk21-linux//:jdk"],
        "@bazel_tools//src/conditions:darwin_x86_64": ["@jdk21-osx//:jdk"],
        "@bazel_tools//src/conditions:darwin": ["@jdk21-osx//:jdk"],
    }),
    java = select({
        "@bazel_tools//src/conditions:linux_x86_64": "@jdk21-linux//:java",
        "@bazel_tools//src/conditions:darwin_x86_64": "@jdk21-osx//:java",
        "@bazel_tools//src/conditions:darwin": "@jdk21-osx//:java",
    }),
    visibility = ["//visibility:public"],
)
