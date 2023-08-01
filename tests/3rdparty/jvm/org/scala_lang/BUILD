load("@rules_scala3//rules:scala.bzl", "scala_import")
scala_import(
    name = "scala3_library",
    exports = [
        "@scala_library_3_3_1//jar"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "scala3_library_sjs1",
    jars = [
        "//external:jar/org/scala_lang/scala3_library_sjs1_3"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_js:scalajs_library",
        ":scala_library"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "scala_library",
    exports = [
        "@scala_library_2_13_11//jar"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)
