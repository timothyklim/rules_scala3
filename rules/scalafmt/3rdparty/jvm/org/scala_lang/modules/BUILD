load("@rules_scala3//rules:scala.bzl", "scala_import")
scala_import(
    name = "scala_collection_compat",
    jars = [
        "//external:jar/org/scala_lang/modules/scala_collection_compat_2_13"
    ],
    runtime_deps = [
        "//rules/scalafmt/3rdparty/jvm/org/scala_lang:scala_library"
    ],
    visibility = [
        "//rules/scalafmt/3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "scala_parallel_collections",
    jars = [
        "//external:jar/org/scala_lang/modules/scala_parallel_collections_2_13"
    ],
    runtime_deps = [
        "//rules/scalafmt/3rdparty/jvm/org/scala_lang:scala_library"
    ],
    visibility = [
        "//rules/scalafmt/3rdparty/jvm:__subpackages__"
    ]
)
