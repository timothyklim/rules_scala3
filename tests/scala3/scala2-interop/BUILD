load("@rules_scala3//rules:scala.bzl", "scala_binary", "scala_library")

scala_library(
    name = "lib3",
    srcs = ["Scala3.scala"],
)

scala_binary(
    name = "app",
    srcs = ["Scala2.scala"],
    scala = "@rules_scala3//scala:2_13",
    scalacopts = [
        "-Ytasty-reader",
    ],
    deps = [
        ":lib3",
    ],
)
