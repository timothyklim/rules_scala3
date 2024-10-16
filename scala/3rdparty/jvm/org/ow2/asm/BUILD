load("@rules_scala3//rules:scala.bzl", "scala_import")
java_import(
    name = "asm",
    jars = [
        "//external:jar/org/ow2/asm/asm"
    ],
    visibility = [
        "//scala/3rdparty/jvm:__subpackages__"
    ]
)

java_import(
    name = "asm_commons",
    jars = [
        "//external:jar/org/ow2/asm/asm_commons"
    ],
    runtime_deps = [
        ":asm",
        ":asm_tree"
    ],
    visibility = [
        "//scala/3rdparty/jvm:__subpackages__"
    ]
)

java_import(
    name = "asm_tree",
    jars = [
        "//external:jar/org/ow2/asm/asm_tree"
    ],
    runtime_deps = [
        ":asm"
    ],
    visibility = [
        "//scala/3rdparty/jvm:__subpackages__"
    ]
)
