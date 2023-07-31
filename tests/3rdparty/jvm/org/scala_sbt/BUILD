load("@rules_scala3//rules:scala.bzl", "scala_import")
java_import(
    name = "compiler_interface",
    jars = [
        "//external:jar/org/scala_sbt/compiler_interface"
    ],
    runtime_deps = [
        ":util_interface"
    ],
    visibility = [
        "//visibility:public"
    ]
)

java_import(
    name = "test_interface",
    jars = [
        "//external:jar/org/scala_sbt/test_interface"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

java_import(
    name = "util_interface",
    jars = [
        "//external:jar/org/scala_sbt/util_interface"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)
