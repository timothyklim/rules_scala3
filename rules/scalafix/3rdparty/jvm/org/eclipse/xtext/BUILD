load("@rules_scala3//rules:scala.bzl", "scala_import")
java_import(
    name = "org_eclipse_xtext_xbase_lib",
    jars = [
        "//external:jar/org/eclipse/xtext/org_eclipse_xtext_xbase_lib"
    ],
    runtime_deps = [
        "//rules/scalafix/3rdparty/jvm/com/google/guava:guava"
    ],
    visibility = [
        "//rules/scalafix/3rdparty/jvm:__subpackages__"
    ]
)
