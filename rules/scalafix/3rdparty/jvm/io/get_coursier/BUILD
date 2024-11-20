load("@rules_scala3//rules:scala.bzl", "scala_import")
java_import(
    name = "interface",
    jars = [
        "//external:jar/io/get_coursier/interface"
    ],
    runtime_deps = [
        "//rules/scalafix/3rdparty/jvm/org/slf4j:slf4j_api"
    ],
    visibility = [
        "//rules/scalafix/3rdparty/jvm:__subpackages__"
    ]
)
