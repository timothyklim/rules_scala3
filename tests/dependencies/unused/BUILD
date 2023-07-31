load("@rules_scala3//rules:scala.bzl", "scala_library")

scala_library(
    name = "0_used",
    srcs = ["0_used.scala"],
    scala = "//scala:2_13",
    tags = ["manual"],
    deps = [
        "@annex_test//:org_scalacheck_scalacheck_2_13",
    ],
)

scala_library(
    name = "0_unused",
    srcs = ["0_unused.scala"],
    scala = "//scala:2_13",
    tags = ["manual"],
    deps = [
        "@annex_test//:org_scalacheck_scalacheck_2_13",
    ],
)

scala_library(
    name = "0_unused_whitelist",
    srcs = ["0_unused.scala"],
    deps_used_whitelist = [
        "@annex_test//:org_scalacheck_scalacheck_2_13",
    ],
    scala = "//scala:2_13",
    tags = ["manual"],
    deps = [
        "@annex_test//:org_scalacheck_scalacheck_2_13",
    ],
)
