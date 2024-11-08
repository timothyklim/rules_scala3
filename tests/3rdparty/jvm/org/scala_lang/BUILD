load("@rules_scala3//rules:scala.bzl", "scala_import")
scala_import(
    name = "scala3_library",
    exports = [
        "@scala3_library//jar"
    ],
    visibility = [
        "//visibility:public"
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
        "//visibility:public"
    ]
)

scala_import(
    name = "scala_compiler",
    jars = [
        "//external:jar/org/scala_lang/scala_compiler"
    ],
    runtime_deps = [
        "//3rdparty/jvm/jline:jline",
        "//3rdparty/jvm/org/fusesource/jansi:jansi",
        ":scala_library",
        ":scala_reflect"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "scala_library",
    exports = [
        "@scala_library_2_13//jar"
    ],
    visibility = [
        "//visibility:public"
    ]
)

scala_import(
    name = "scala_reflect",
    exports = [
        "@scala_reflect_2_13//jar"
    ],
    visibility = [
        "//visibility:public"
    ]
)
