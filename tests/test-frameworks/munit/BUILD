load("@rules_scala3//rules:scala.bzl", "scala_test")

scala_test(
    name = "tests",
    srcs = ["MunitSpec.scala"],
    frameworks = ["munit.Framework"],
    deps = [
        "@annex_test//:org_scalacheck_scalacheck_3",
        "@annex_test//:org_scalameta_munit_3",
        "@annex_test//:org_scalameta_munit_scalacheck_3",
    ],
)
