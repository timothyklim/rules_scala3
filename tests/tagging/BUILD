load("@rules_scala3//rules:scala.bzl", "scala_binary", "scala_library", "scala_test")
load(
    "@rules_scala3//rules/common:private/utils.bzl",
    _PROPAGATABLE_TAGS = "PROPAGATABLE_TAGS",
)

scala_binary(
    name = "binary-all-propagatable",
    srcs = ["A.scala"],
    scala = "@rules_scala3//scala:3_4",
    tags = ["manual"] + _PROPAGATABLE_TAGS,
)

scala_library(
    name = "library-no-propagatable",
    srcs = ["A.scala"],
    scala = "@rules_scala3//scala:3_4",
    tags = [
        "manual",
        "requires-network",
    ],
)

scala_test(
    name = "test-no-remote-only",
    srcs = ["A.scala"],
    scala = "@rules_scala3//scala:3_4",
    tags = [
        "manual",
        "no-remote",
    ],
)
