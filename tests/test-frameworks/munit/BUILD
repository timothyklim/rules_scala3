load("@rules_scala3//rules:scala.bzl", "scala_test")

scala_test(
    name = "tests",
    srcs = ["MunitSpec.scala"],
    frameworks = ["munit.Framework"],
    scala = "//scala:zinc_3_0_0",
    deps = [
        "@annex_test//:org_scalacheck_scalacheck_3_0_0_RC3",
        "@annex_test//:org_scalameta_munit_3_0_0_RC3",
        "@annex_test//:org_scalameta_munit_scalacheck_3_0_0_RC3",
    ],
)
