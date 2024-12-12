load("@rules_scala3//rules:scala.bzl", "scala_import")
java_import(
    name = "scala_asm",
    jars = [
        "//external:jar/org/scala_lang/modules/scala_asm"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "scala_collection_compat",
    jars = [
        "//external:jar/org/scala_lang/modules/scala_collection_compat_2_13"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_lang:scala_library"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)
