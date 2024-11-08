load("@rules_scala3//rules:scala.bzl", "scala_library")
load(":rules.bzl", "my_plugin")

scala_library(
    name = "my_plugin_lib",
    srcs = ["plugin.scala"],
    scala = "@rules_scala3//scala:3_4",
    tags = ["manual"],
)

my_plugin(
    name = "my_plugin",
    tags = ["manual"],
    deps = [
        ":my_plugin_lib",
    ],
)

scala_library(
    name = "usage",
    srcs = ["usage.scala"],
    plugins = [
        ":my_plugin",
    ],
    scala = "@rules_scala3//scala:3_4",
    tags = ["manual"],
)
