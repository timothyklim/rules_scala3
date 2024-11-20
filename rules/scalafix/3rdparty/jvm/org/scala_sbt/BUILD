load("@rules_scala3//rules:scala.bzl", "scala_import")
scala_import(
    name = "compiler_interface",
    jars = [
        "//external:jar/org/scala_sbt/compiler_interface"
    ],
    runtime_deps = [
        ":util_interface"
    ],
    visibility = [
        "//rules/scalafix/3rdparty/jvm:__subpackages__"
    ]
)

java_import(
    name = "util_interface",
    jars = [
        "//external:jar/org/scala_sbt/util_interface"
    ],
    visibility = [
        "//rules/scalafix/3rdparty/jvm:__subpackages__"
    ]
)
