load("@rules_scala3//rules:scala.bzl", "scala_library")

scala_library(
    name = "plain",
    resource_strip_prefix = "resources/reference_conf",
    resources = ["reference.conf"],
    scala = "@rules_scala3//scala:3_4",
)

java_library(
    name = "plain_java",
    resource_strip_prefix = "resources/reference_conf",
    resources = ["reference.conf"],
)
