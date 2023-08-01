load("@rules_scala3//rules:scala.bzl", "scala_binary")

scala_binary(
    name = "bad",
    srcs = ["Main.scala"],
)

scala_binary(
    name = "good",
    srcs = ["Main.scala"],
    deps = ["//3rdparty/jvm/org/scala_lang/modules:scala_xml"],
)
