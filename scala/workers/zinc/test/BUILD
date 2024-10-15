load("//rules:scala.bzl", "scala_library")
load("//rules:scalafmt.bzl", "scala_format_test")

scala_library(
    name = "test",
    srcs = glob(["**/*.scala"]),
    visibility = ["//visibility:public"],
    deps = [
        "//scala/common/sbt-testing:common",
        "//scala/workers/common",
        "//scala/3rdparty/jvm/org/scala_sbt:test_interface",
        "//scala/3rdparty/jvm/org/scala_sbt:compiler_interface",
        "//3rdparty/jvm/com/github/scopt",
        "//scala/3rdparty/jvm/org/scala_sbt:zinc_apiinfo",
        "//scala/3rdparty/jvm/org/scala_sbt:zinc_core",
        "@annex//:org_scala_sbt_zinc_persist_3",
        # "//scala/3rdparty/jvm/org/scala_sbt:zinc_persist_core_assembly",
    ],
)

scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)
