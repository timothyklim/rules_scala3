load("@rules_scala3//rules:scala.bzl", "scala_import")
scala_import(
    name = "paiges_core",
    jars = [
        "//external:jar/org/typelevel/paiges_core_2_13"
    ],
    runtime_deps = [
        "//rules/scalafmt/3rdparty/jvm/org/scala_lang:scala_library"
    ],
    visibility = [
        "//rules/scalafmt/3rdparty/jvm:__subpackages__"
    ]
)
