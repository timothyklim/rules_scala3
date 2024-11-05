load("@rules_scala3//rules:scala.bzl", "scala_library")

scala_library(
    name = "0_used",
    srcs = ["0_used.scala"],
    scala = "@rules_scala3//scala:3_4",
    tags = ["manual"],
    deps = [
        "//3rdparty/jvm/org/scalacheck",
    ],
)

scala_library(
    name = "0_unused",
    srcs = ["0_unused.scala"],
    scala = "@rules_scala3//scala:3_4",
    tags = ["manual"],
    deps = [
        "//3rdparty/jvm/org/scalacheck",
    ],
)

scala_library(
    name = "0_unused_whitelist",
    srcs = ["0_unused.scala"],
    deps_used_whitelist = [
        "//3rdparty/jvm/org/scalacheck",
    ],
    scala = "@rules_scala3//scala:3_4",
    tags = ["manual"],
    deps = [
        "//3rdparty/jvm/org/scalacheck",
    ],
)
