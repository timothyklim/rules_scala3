load("@rules_scala3//rules:scala.bzl", "scala_import")
java_import(
    name = "jsr305",
    jars = [
        "//external:jar/com/google/code/findbugs/jsr305"
    ],
    visibility = [
        "//rules/scalafix/3rdparty/jvm:__subpackages__"
    ]
)
