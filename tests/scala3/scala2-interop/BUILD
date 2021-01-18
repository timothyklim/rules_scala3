load("@rules_scala_annex//rules:scala.bzl", "scala_binary", "scala_library")

scala_library(
    name = "lib3",
    srcs = ["Scala3.scala"],
    scala = "//scala:zinc_3_0",
    macro = True, # TODO
    scalacopts = [
      "-deprecation",
      "-encoding",
      "UTF-8",
      "-feature",
      "-unchecked"
    ]
)

scala_binary(
    name = "app",
    srcs = ["Scala2.scala"],
    scala = "//scala:zinc_2_13",
    deps = [
      ":lib3",
    ],
    scalacopts = [
      "-Ytasty-reader",
    ]
)
