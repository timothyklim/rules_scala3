load("@rules_scala3//rules:scala.bzl", "scala_import")
java_import(
    name = "org_eclipse_jgit",
    jars = [
        "//external:jar/org/eclipse/jgit/org_eclipse_jgit"
    ],
    runtime_deps = [
        "//3rdparty/jvm/com/googlecode/javaewah:JavaEWAH",
        "//3rdparty/jvm/org/slf4j:slf4j_api"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)
