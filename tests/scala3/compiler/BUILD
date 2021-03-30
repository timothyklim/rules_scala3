load("@rules_scala3//rules:scala.bzl", "scala_binary")

scala_binary(
    name = "app",
    srcs = glob(["*.scala"]),
    scala = "//scala:zinc_3_0_0",
    scalacopts = [
        "-deprecation",
        "-encoding",
        "UTF-8",
        "-feature",
        "-unchecked",
        "-source:3.0",
        "-rewrite",
        "-indent",
    ],
)
