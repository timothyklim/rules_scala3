load("@rules_scala3//rules:scala.bzl", "scala_import")
java_import(
    name = "org_eclipse_jgit",
    jars = [
        "//external:jar/org/eclipse/jgit/org_eclipse_jgit"
    ],
    runtime_deps = [
        "//rules/scalafix/3rdparty/jvm/com/googlecode/javaewah:JavaEWAH",
        "//rules/scalafix/3rdparty/jvm/org/slf4j:slf4j_api"
    ],
    visibility = [
        "//rules/scalafix/3rdparty/jvm:__subpackages__"
    ]
)
