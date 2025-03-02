load("@rules_scala3//rules:scala.bzl", "scala_import")
scala_import(
    name = "fansi",
    jars = [
        "//external:jar/com/lihaoyi/fansi_3"
    ],
    runtime_deps = [
        "//scala/3rdparty/jvm/org/scala_lang:scala3_library",
        ":sourcecode"
    ],
    visibility = [
        "//visibility:public"
    ]
)

scala_import(
    name = "pprint",
    jars = [
        "//external:jar/com/lihaoyi/pprint_3"
    ],
    runtime_deps = [
        "//scala/3rdparty/jvm/org/scala_lang:scala3_library",
        ":fansi",
        ":sourcecode"
    ],
    visibility = [
        "//visibility:public"
    ]
)

scala_import(
    name = "sourcecode",
    jars = [
        "//external:jar/com/lihaoyi/sourcecode_3"
    ],
    runtime_deps = [
        "//scala/3rdparty/jvm/org/scala_lang:scala3_library"
    ],
    visibility = [
        "//scala/3rdparty/jvm:__subpackages__"
    ]
)
