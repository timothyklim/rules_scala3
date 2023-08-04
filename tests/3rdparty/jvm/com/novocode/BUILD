load("@rules_scala3//rules:scala.bzl", "scala_import")
java_import(
    name = "junit_interface",
    jars = [
        "//external:jar/com/novocode/junit_interface"
    ],
    runtime_deps = [
        "//3rdparty/jvm/junit:junit",
        "//3rdparty/jvm/org/scala_sbt:test_interface"
    ],
    visibility = [
        "//visibility:public"
    ]
)
