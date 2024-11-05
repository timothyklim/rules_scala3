load("@rules_scala3//rules:scala.bzl", "scala_binary", "scala_library")

scala_library(
    name = "library",
    srcs = ["Library.scala"],
    neverlink = True,
    scala = "@rules_scala3//scala:3_4",
)

scala_binary(
    name = "binary",
    srcs = ["Binary.scala"],
    scala = "@rules_scala3//scala:3_4",
    deps = [":library"],
)
