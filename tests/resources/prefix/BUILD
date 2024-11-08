load("@rules_scala3//rules:scala.bzl", "scala_library")

scala_library(
    name = "prefix",
    resource_strip_prefix = package_name(),
    resources = glob(["**/*.txt"]),
    scala = "@rules_scala3//scala:3_4",
)

scala_library(
    name = "outside",
    resource_strip_prefix = "{}/other".format(package_name()),
    resources = glob(["**/*.txt"]),
    scala = "@rules_scala3//scala:3_4",
)
