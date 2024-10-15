load("@rules_scala3//rules:scala.bzl", "scala_import")
java_import(
    name = "jna",
    jars = [
        "//external:jar/net/java/dev/jna/jna"
    ],
    visibility = [
        "//scala/3rdparty/jvm:__subpackages__"
    ]
)

java_import(
    name = "jna_platform",
    jars = [
        "//external:jar/net/java/dev/jna/jna_platform"
    ],
    runtime_deps = [
        ":jna"
    ],
    visibility = [
        "//scala/3rdparty/jvm:__subpackages__"
    ]
)
