load("//rules:scala.bzl", "scala_binary")
load("//rules:scalafmt.bzl", "scala_format_test")

scala_binary(
    name = "repl",
    srcs = glob(["**/*.scala"]),
    visibility = ["//visibility:public"],
    runtime_deps = [
        "@annex//:org_jline_jline_reader",
    ],
    deps = [
        "//scala/workers/common",
        "@annex//:com_github_scopt_scopt_3",
        "@annex//:org_scala_sbt_compiler_interface",
        "@annex//:org_scala_sbt_util_interface",
        "@annex//:org_scala_sbt_util_logging_3",
        "@annex//:org_scala_sbt_zinc_3",
        "@annex//:org_scala_sbt_zinc_classpath_3",
        "@annex//:org_scala_sbt_zinc_compile_core_3",
    ],
)

scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)
