load("@rules_scala3//rules:scala.bzl", "scala_import")
java_import(
    name = "scala_asm",
    jars = [
        "//external:jar/org/scala_lang/modules/scala_asm"
    ],
    visibility = [
        "//rules/scalafix/3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "scala_collection_compat",
    jars = [
        "//external:jar/org/scala_lang/modules/scala_collection_compat_2_13"
    ],
    runtime_deps = [
        "//rules/scalafix/3rdparty/jvm/org/scala_lang:scala_library"
    ],
    visibility = [
        "//rules/scalafix/3rdparty/jvm:__subpackages__"
    ]
)
