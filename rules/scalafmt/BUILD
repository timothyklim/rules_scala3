load("//deps:scala_deps.bzl", "scala_deps")
load("//rules:scala.bzl", "scala_binary")
load("//rules:scalafmt.bzl", "scala_format_test")
load(
    ":ext.bzl",
    _add_non_default_format_phase_singleton = "add_non_default_format_phase_singleton",
)

filegroup(
    name = "dependencies",
    srcs = ["Dependencies.scala"],
    visibility = ["//visibility:public"],
)

scala_deps(
    name = "scala_deps",
    src = "//rules/scalafmt:dependencies",
    dependencies = "rules_scala3.rules.scalafmt.Dependencies",
)

filegroup(
    name = "runner",
    srcs = ["private/format.template.sh"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "testrunner",
    srcs = ["private/format-test.template.sh"],
    visibility = ["//visibility:public"],
)

scala_binary(
    name = "scalafmt",
    srcs = glob(["scalafmt/**/*.scala"]),
    main_class = "annex.scalafmt.ScalafmtRunner",
    scala = "//scala:bootstrap_3",
    visibility = ["//visibility:public"],
    deps = [
        "//3rdparty/jvm/com/github/scopt",
        "//rules/scalafmt/3rdparty/jvm/com/geirsson:metaconfig_core",
        "//rules/scalafmt/3rdparty/jvm/org/scalameta:parsers",
        "//rules/scalafmt/3rdparty/jvm/org/scalameta:scalafmt_core",
        "//rules/scalafmt/3rdparty/jvm/org/scalameta:scalafmt_sysops",
        "//rules/scalafmt/3rdparty/jvm/org/scalameta:trees",
        "//scala/common/worker",
        "//scala/workers/common",
    ],
)

scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)

filegroup(
    name = "bzl",
    srcs = glob(["**/*.bzl"]),
    visibility = ["//rules:__pkg__"],
)

_add_non_default_format_phase_singleton(
    name = "add_non_default_format_phase",
    visibility = ["//visibility:public"],
)
