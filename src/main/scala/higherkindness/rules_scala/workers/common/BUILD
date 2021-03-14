load("//rules:scala.bzl", "scala_library")
load("//rules:scalafmt.bzl", "scala_format_test")

scala_library(
    name = "common",
    srcs = glob(["**/*.scala"]),
    scala = "//src/main/scala:bootstrap_3_0_0",
    visibility = ["//visibility:public"],
    deps = [
        "@annex//:net_sourceforge_argparse4j_argparse4j",
        "@annex//:org_scala_sbt_zinc_core_2_13",
    ],
)

scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)
