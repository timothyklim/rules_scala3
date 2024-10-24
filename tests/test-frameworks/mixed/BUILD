load("@rules_scala3//rules:scala.bzl", "scala_test")

scala_test(
    name = "mixed",
    srcs = glob(["*.scala"]),
    shard_count = 2,
    tags = ["manual"],
    runtime_deps = [
        "//3rdparty/jvm/org/hamcrest:hamcrest_core",
        "//3rdparty/jvm/org/scalameta:junit_interface",
    ],
    deps = [
        "//3rdparty/jvm/junit",
        "//3rdparty/jvm/org/scalacheck",
    ],
)
