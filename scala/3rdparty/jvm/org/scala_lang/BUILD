load("@rules_scala3//rules:scala.bzl", "scala_import")
scala_import(
    name = "scala3_library",
    exports = [
        "@scala3_library//jar"
    ],
    visibility = [
        "//scala/3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "scala_reflect",
    exports = [
        "@scala_reflect_2_13//jar"
    ],
    visibility = [
        "//scala/3rdparty/jvm:__subpackages__"
    ]
)
