load("@rules_scala3//rules:scala.bzl", "scala_import", "scala_library")

scala_import(
    name = "shapeless",
    jars = [
        "//external:jar/com/chuusai/shapeless_2_13",
    ],
    visibility = [
        "//visibility:public",
    ],
)

scala_library(
    name = "scalaimport",
    srcs = ["scalaimport.scala"],
    deps = [
        ":shapeless",
        "//3rdparty/jvm/org/scala_lang/modules:scala_xml",
    ],
)
