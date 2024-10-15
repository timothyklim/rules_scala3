load("//rules:scala.bzl", "scala_library")
load("//rules:scalafmt.bzl", "scala_format_test")

_subprocess_srcs = ["SubprocessRunner.scala"]

_common_srcs = [
    f
    for f in glob(["**/*.scala"])
    if f not in _subprocess_srcs
]

scala_library(
    name = "subprocess",
    srcs = _subprocess_srcs,
    visibility = ["//visibility:public"],
    deps = [
        ":common",
        "//scala/3rdparty/jvm/org/scala_sbt:test_interface",
    ],
)

scala_library(
    name = "common",
    srcs = _common_srcs,
    visibility = ["//visibility:public"],
    deps = [
        "//scala/3rdparty/jvm/org/scala_lang/modules:scala_xml",
        "//scala/3rdparty/jvm/org/scala_sbt:test_interface",
    ],
)

scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)
