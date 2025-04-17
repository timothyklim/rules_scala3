load("@rules_scala3//rules:scala.bzl", "scala_import")
scala_import(
    name = "jline",
    jars = [
        "//external:jar/org/scala_sbt/jline/jline"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/fusesource/jansi:jansi"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)
