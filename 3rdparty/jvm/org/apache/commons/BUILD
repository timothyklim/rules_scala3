load("@rules_scala3//rules:scala.bzl", "scala_import")
java_import(
    name = "commons_lang3",
    jars = [
        "//external:jar/org/apache/commons/commons_lang3"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

java_import(
    name = "commons_math3",
    jars = [
        "//external:jar/org/apache/commons/commons_math3"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

java_import(
    name = "commons_text",
    jars = [
        "//external:jar/org/apache/commons/commons_text"
    ],
    runtime_deps = [
        ":commons_lang3"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)
