load("@rules_scala3//rules:scala.bzl", "scala_binary", "scala_library")

scala_library(
    name = "lib3",
    srcs = ["Scala3.scala"],
    scala = "//scala:zinc_3_0_0",
)

scala_binary(
    name = "app",
    srcs = ["Scala2.scala"],
    scala = "//scala:zinc_2_13",
    scalacopts = [
        "-Ytasty-reader",
    ],
    deps = [
        ":lib3",
    ],
)
