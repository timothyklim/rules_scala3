load("@rules_scala3//rules:scala.bzl", "scala_import")
scala_import(
    name = "fansi",
    jars = [
        "//external:jar/com/lihaoyi/fansi_2_13"
    ],
    runtime_deps = [
        "//rules/scalafmt/3rdparty/jvm/org/scala_lang:scala_library",
        ":sourcecode"
    ],
    visibility = [
        "//rules/scalafmt/3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "sourcecode",
    jars = [
        "//external:jar/com/lihaoyi/sourcecode_2_13"
    ],
    runtime_deps = [
        "//rules/scalafmt/3rdparty/jvm/org/scala_lang:scala_library"
    ],
    visibility = [
        "//rules/scalafmt/3rdparty/jvm:__subpackages__"
    ]
)
