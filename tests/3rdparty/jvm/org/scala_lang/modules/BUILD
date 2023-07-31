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

scala_import(
    name = "scala_collection_compat_sjs1",
    jars = [
        "//external:jar/org/scala_lang/modules/scala_collection_compat_sjs1_3"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_js:scalajs_library",
        "//3rdparty/jvm/org/scala_lang:scala3_library_sjs1"
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
        "//visibility:public"
    ]
)
