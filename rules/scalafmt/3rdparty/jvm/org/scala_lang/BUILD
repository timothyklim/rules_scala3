load("@rules_scala3//rules:scala.bzl", "scala_import")
scala_import(
    name = "scala_compiler",
    jars = [
        "//external:jar/org/scala_lang/scala_compiler"
    ],
    runtime_deps = [
        "//rules/scalafmt/3rdparty/jvm/io/github/java_diff_utils:java_diff_utils",
        "//rules/scalafmt/3rdparty/jvm/net/java/dev/jna:jna",
        "//rules/scalafmt/3rdparty/jvm/org/jline:jline",
        ":scala_library",
        ":scala_reflect"
    ],
    visibility = [
        "//rules/scalafmt/3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "scala_library",
    exports = [
        "@scala_library_2_13//jar"
    ],
    visibility = [
        "//rules/scalafmt/3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "scala_reflect",
    exports = [
        "@scala_reflect_2_13//jar"
    ],
    visibility = [
        "//rules/scalafmt/3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "scalap",
    jars = [
        "//external:jar/org/scala_lang/scalap"
    ],
    runtime_deps = [
        ":scala_compiler"
    ],
    visibility = [
        "//rules/scalafmt/3rdparty/jvm:__subpackages__"
    ]
)
