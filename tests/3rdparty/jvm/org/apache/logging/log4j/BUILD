load("@rules_scala3//rules:scala.bzl", "scala_import")
scala_import(
    name = "log4j_api",
    jars = [
        "//external:jar/org/apache/logging/log4j/log4j_api"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "log4j_core",
    jars = [
        "//external:jar/org/apache/logging/log4j/log4j_core"
    ],
    runtime_deps = [
        ":log4j_api"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)
