load("@rules_scala3//rules:scala.bzl", "scala_binary")

scala_binary(
    name = "lib",
    srcs = ["Example.scala"],
    deps = [
        "//3rdparty/jvm/org/scala_sbt:util_interface",
        "//3rdparty/jvm/org/scala_sbt:util_logging",
        "//3rdparty/jvm/org/scala_sbt:zinc_compile_core",
        "@rules_scala3//scala/workers/common",
    ],
)
