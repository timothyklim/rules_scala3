load("@rules_scala3//rules:scala.bzl", "scala_binary", "scala_library")

scala_library(
    name = "bad",
    srcs = ["Reflect.scala"],
    scala = "@rules_scala3//scala:2_13",
)

scala_binary(
    name = "good",
    srcs = ["Reflect.scala"],
    deps_used_whitelist = ["//3rdparty/jvm/org/scala_lang:scala_reflect"],
    scala = "@rules_scala3//scala:3_4",
    deps = ["//3rdparty/jvm/org/scala_lang:scala_reflect"],
)
