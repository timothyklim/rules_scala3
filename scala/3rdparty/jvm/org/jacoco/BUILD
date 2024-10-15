load("@rules_scala3//rules:scala.bzl", "scala_import")
java_import(
    name = "org_jacoco_core",
    jars = [
        "//external:jar/org/jacoco/org_jacoco_core"
    ],
    runtime_deps = [
        "//scala/3rdparty/jvm/org/ow2/asm:asm",
        "//scala/3rdparty/jvm/org/ow2/asm:asm_commons",
        "//scala/3rdparty/jvm/org/ow2/asm:asm_tree"
    ],
    visibility = [
        "//visibility:public"
    ]
)
