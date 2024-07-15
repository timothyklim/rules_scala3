load("@rules_scala3//rules:scala.bzl", "scala_library")


config_setting(
    name = "a2",
    values = {"define": "a2=true"},
    visibility = ["//visibility:public"],
)

scala_library(
    name = "a",
    srcs = select({
      ":a2": ["A2.scala"],
      "//conditions:default": ["A1.scala"],
    }),
)

scala_library(
    name = "lib",
    srcs = ["B.scala"],
    deps = [":a"],
)
