load("//rules:scalafmt.bzl", "scala_format_test")
load("//scala3:defs.bzl", "worker_scala_library")

worker_scala_library(
    name = "common",
    srcs = glob(["**/*.scala"]),
    visibility = ["//visibility:public"],
    deps = [
        "//3rdparty/jvm/com/github/scopt",
        "//scala/3rdparty/jvm/org/scala_sbt:compiler_interface",
        "//scala/3rdparty/jvm/org/scala_sbt:util_interface",
        "//scala/3rdparty/jvm/org/scala_sbt:util_logging",
        "//scala/3rdparty/jvm/org/scala_sbt:zinc_classpath",
        "//scala/3rdparty/jvm/org/scala_sbt:zinc_compile_core",
    ],
)

scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)
