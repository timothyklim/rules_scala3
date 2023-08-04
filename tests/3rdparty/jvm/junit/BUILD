load("@rules_scala3//rules:scala.bzl", "scala_import")
java_import(
    name = "junit",
    jars = [
        "//external:jar/junit/junit"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/hamcrest:hamcrest_core"
    ],
    visibility = [
        "//visibility:public"
    ]
)
