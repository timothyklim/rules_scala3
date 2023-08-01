load("@rules_scala3//rules:scala.bzl", "scala_import")
scala_import(
    name = "scalacheck",
    jars = [
        "//external:jar/org/scalacheck/scalacheck_3"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_lang:scala3_library",
        "//3rdparty/jvm/org/scala_sbt:test_interface"
    ],
    visibility = [
        "//visibility:public"
    ]
)
