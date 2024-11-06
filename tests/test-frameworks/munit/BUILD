load("@rules_scala3//rules:scala.bzl", "scala_test")

scala_test(
    name = "tests",
    srcs = ["MunitSpec.scala"],
    jvm_flags = ["-Dfile.encoding=UTF-8"],
    deps = [
        "//3rdparty/jvm/org/scalacheck",
        "//3rdparty/jvm/org/scalameta:munit",
        "//3rdparty/jvm/org/scalameta:munit_diff",
        "//3rdparty/jvm/org/scalameta:munit_scalacheck",
    ],
)
