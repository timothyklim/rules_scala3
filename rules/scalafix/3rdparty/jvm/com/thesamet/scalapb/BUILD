load("@rules_scala3//rules:scala.bzl", "scala_import")
scala_import(
    name = "lenses",
    jars = [
        "//external:jar/com/thesamet/scalapb/lenses_2_13"
    ],
    runtime_deps = [
        "//rules/scalafix/3rdparty/jvm/org/scala_lang/modules:scala_collection_compat",
        "//rules/scalafix/3rdparty/jvm/org/scala_lang:scala_library"
    ],
    visibility = [
        "//rules/scalafix/3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "scalapb_runtime",
    jars = [
        "//external:jar/com/thesamet/scalapb/scalapb_runtime_2_13"
    ],
    runtime_deps = [
        "//rules/scalafix/3rdparty/jvm/com/google/protobuf:protobuf_java",
        "//rules/scalafix/3rdparty/jvm/org/scala_lang/modules:scala_collection_compat",
        "//rules/scalafix/3rdparty/jvm/org/scala_lang:scala_library",
        ":lenses"
    ],
    visibility = [
        "//rules/scalafix/3rdparty/jvm:__subpackages__"
    ]
)
