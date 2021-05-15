load("//rules:scala.bzl", "scala_library")
load("//rules:scalafmt.bzl", "scala_format_test")

scala_library(
    name = "test",
    srcs = glob(["**/*.scala"]),
    visibility = ["//visibility:public"],
    deps = [
        "//scala/common/sbt-testing:common",
        "//scala/workers/common",
        "@annex//:com_github_scopt_scopt_3",
        "@annex//:org_scala_sbt_compiler_interface",
        "@annex//:org_scala_sbt_test_interface",
        "@annex//:org_scala_sbt_zinc_apiinfo_2_13",
        "@annex//:org_scala_sbt_zinc_core_2_13",
        "@annex//:org_scala_sbt_zinc_persist_2_13",
        "@annex//:org_scala_sbt_zinc_persist_core_assembly",
    ],
)

scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)
