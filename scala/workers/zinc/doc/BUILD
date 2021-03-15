load("//rules:scala.bzl", "scala_binary")
load("//rules:scalafmt.bzl", "scala_format_test")

scala_binary(
    name = "doc",
    srcs = glob(["**/*.scala"]),
    scala = "//scala:zinc",
    visibility = ["//visibility:public"],
    deps = [
        "//scala/common/worker",
        "//scala/workers/common",
        "@annex//:net_sourceforge_argparse4j_argparse4j",
        "@annex//:org_scala_sbt_compiler_interface",
        "@annex//:org_scala_sbt_util_interface",
        "@annex//:org_scala_sbt_util_logging_2_13",
        "@annex//:org_scala_sbt_zinc_2_13",
        "@annex//:org_scala_sbt_zinc_classpath_2_13",
        "@annex//:org_scala_sbt_zinc_compile_core_2_13",
    ],
)

scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)
