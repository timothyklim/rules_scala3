load("//rules/scalafix:scalafix_runner.bzl", "scalafix_runner")

scalafix_runner(
    name = "run_scalafix",
    toolchain = "//:scalafix_toolchain",
    targets = ["//deps:deps"],
)
