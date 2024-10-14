load("@rules_scala3//rules:scala.bzl", "scala_import")
scala_import(
    name = "scala_collection_compat",
    jars = [
        "//external:jar/org/scala_lang/modules/scala_collection_compat_3"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_lang:scala3_library"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)
