load("@rules_scala3//rules:scala.bzl", "scala_import")

scala_import(
    name = "scala_compiler",
    jars = [
        "//external:jar/org/scala_lang/scala_compiler",
    ],
    visibility = [
        "//rules/scalafmt/3rdparty/jvm:__subpackages__",
    ],
    runtime_deps = [
        ":scala_library",
        ":scala_reflect",
        "//rules/scalafmt/3rdparty/jvm/io/github/java_diff_utils",
        "//rules/scalafmt/3rdparty/jvm/net/java/dev/jna",
        "//rules/scalafmt/3rdparty/jvm/org/jline",
    ],
)

scala_import(
    name = "scala_library",
    visibility = [
        "//rules/scalafmt/3rdparty/jvm:__subpackages__",
    ],
    exports = [
        "@scala_library_2_13//jar",
    ],
)

scala_import(
    name = "scala_reflect",
    visibility = [
        "//rules/scalafmt/3rdparty/jvm:__subpackages__",
    ],
    exports = [
        "@scala_reflect_2_13//jar",
    ],
)

scala_import(
    name = "scalap",
    jars = [
        "//external:jar/org/scala_lang/scalap",
    ],
    visibility = [
        "//rules/scalafmt/3rdparty/jvm:__subpackages__",
    ],
    runtime_deps = [":scala_compiler"],
)
