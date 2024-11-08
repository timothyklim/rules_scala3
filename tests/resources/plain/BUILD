load("@rules_scala3//rules:scala.bzl", "scala_library")

scala_library(
    name = "plain",
    resources = glob(["**/*.txt"]),
    scala = "@rules_scala3//scala:3_4",
)

scala_library(
    name = "merged",
    resource_jars = [":plain"],
    resource_strip_prefix = "resources",
    resources = glob(["**/*.txt"]),
    scala = "@rules_scala3//scala:3_4",
)
