load("@rules_scala3//rules:scala.bzl", "scala_import")
scala_import(
    name = "scala_parallel_collections",
    jars = [
        "//external:jar/org/scala_lang/modules/scala_parallel_collections_3"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_lang:scala3_library"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "scala_xml",
    jars = [
        "//external:jar/org/scala_lang/modules/scala_xml_3"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_lang:scala3_library"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)
