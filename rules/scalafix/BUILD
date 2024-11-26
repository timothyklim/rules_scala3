load("//rules/scalafix:scalafix_runner.bzl", "scalafix_runner")
load("@rules_scala3//deps:scala_deps.bzl", "scala_deps")

filegroup(
    name = "dependencies",
    srcs = ["Dependencies.scala"],
    visibility = ["//visibility:public"],
)

scala_deps(
    name = "scala_deps",
    src = "//rules/scalafix:dependencies",
    dependencies = "rules_scala3.rules.scalafix.Dependencies",
)

scalafix_runner(
    name = "run_scalafix",
    toolchain = "//:scalafix_toolchain",
    targets = ["//deps:deps"],
)