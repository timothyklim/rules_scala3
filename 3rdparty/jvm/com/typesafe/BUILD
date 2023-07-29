load("@rules_scala3//rules:scala.bzl", "scala_import")
java_import(
    name = "config",
    jars = [
        "//external:jar/com/typesafe/config"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "ssl_config_core",
    jars = [
        "//external:jar/com/typesafe/ssl_config_core_3"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_lang:scala3_library",
        ":config"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)
