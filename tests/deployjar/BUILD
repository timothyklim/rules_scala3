load(
    "@rules_scala3//rules:scala.bzl",
    "scala_binary",
    "scala_library",
)

scala_binary(
    name = "TestBinary",
    srcs = ["TestBinary.scala"],
    deps = [":TestClass"],
)

scala_library(
    name = "TestClass",
    srcs = ["TestClass.scala"],
)
