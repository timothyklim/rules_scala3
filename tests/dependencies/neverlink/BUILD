load("@rules_scala3//rules:scala.bzl", "scala_binary", "scala_library")

scala_library(
    name = "library",
    srcs = ["Library.scala"],
    neverlink = True,
    scala = "//scala:2_13",
)

scala_binary(
    name = "binary",
    srcs = ["Binary.scala"],
    scala = "//scala:2_13",
    deps = [":library"],
)
