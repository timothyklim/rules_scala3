load("@rules_scala3//rules:scala.bzl", "scala_library")

scala_library(
    name = "default",
    srcs = ["Deprecated.scala"],
    scala = "@rules_scala3//scala:3_4",
)

scala_library(
    name = "fatal",
    srcs = ["Deprecated.scala"],
    scala = "@rules_scala3//scala:3_4",
    scalacopts = [
        "-deprecation",
        "-Xfatal-warnings",
    ],
)

scala_library(
    name = "warn",
    srcs = ["Deprecated.scala"],
    scala = "@rules_scala3//scala:3_4",
    scalacopts = [
        "-deprecation",
    ],
)

scala_library(
    name = "fatal_glob",
    srcs = ["Deprecated.scala"],
    scala = "//scala:zinc_3_fatal_deprecation_opt",
)
