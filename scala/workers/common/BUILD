load("//rules:scalafmt.bzl", "scala_format_test")
load("//scala3:defs.bzl", "worker_scala_library")

worker_scala_library(
    name = "common",
    srcs = glob(["**/*.scala"]),
    visibility = ["//visibility:public"],
    deps = [
        "//3rdparty/jvm/com/github/scopt",
        "@annex//:org_scala_sbt_compiler_interface",
        "@annex//:org_scala_sbt_util_interface",
        "@annex//:org_scala_sbt_util_logging_3",
        "@annex//:org_scala_sbt_zinc_classpath_3",
        "@annex//:org_scala_sbt_zinc_compile_core_3",
    ],
)

scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)
