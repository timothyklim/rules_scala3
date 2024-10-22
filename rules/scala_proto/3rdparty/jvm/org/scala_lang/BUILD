load("@rules_scala3//rules:scala.bzl", "scala_import")
scala_import(
    name = "scala3_library",
    exports = [
        "@scala3_library//jar"
    ],
    visibility = [
        "//rules/scala_proto/3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "scala_library",
    exports = [
        "@scala_library_2_13//jar"
    ],
    visibility = [
        "//rules/scala_proto/3rdparty/jvm:__subpackages__"
    ]
)
