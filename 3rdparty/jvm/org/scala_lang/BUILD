load("@rules_scala3//rules:scala.bzl", "scala_import")

scala_import(
    name = "scala3_library",
    visibility = [
        "//3rdparty/jvm:__subpackages__",
    ],
    exports = [
        "@scala3_library//jar",
    ],
)

scala_import(
    name = "scala_library",
    visibility = [
        "//3rdparty/jvm:__subpackages__",
    ],
    exports = [
        "@scala_library_2_13//jar",
    ],
)