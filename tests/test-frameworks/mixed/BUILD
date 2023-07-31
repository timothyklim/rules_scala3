load("@rules_scala3//rules:scala.bzl", "scala_test")

scala_test(
    name = "mixed",
    srcs = glob(["*.scala"]),
    shard_count = 2,
    tags = ["manual"],
    runtime_deps = [
        "@hamcrest_core//jar",
        "@junit_interface//jar",
    ],
    deps = [
        "//3rdparty/jvm/org/scalacheck:scalacheck",
        "@junit//jar",
    ],
)
