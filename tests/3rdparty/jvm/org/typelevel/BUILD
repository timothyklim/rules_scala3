load("@rules_scala3//rules:scala.bzl", "scala_import")
scala_import(
    name = "kind_projector",
    jars = [
        "//external:jar/org/typelevel/kind_projector_2_13_1"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_lang:scala_compiler",
        "//3rdparty/jvm/org/scala_lang:scala_library"
    ],
    visibility = [
        "//visibility:public"
    ]
)
