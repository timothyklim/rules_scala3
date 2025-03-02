load("@rules_scala3//rules:scala.bzl", "scala_import")
scala_import(
    name = "jline_native",
    jars = [
        "//external:jar/org/jline/jline_native"
    ],
    visibility = [
        "//scala/3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "jline_reader",
    jars = [
        "//external:jar/org/jline/jline_reader"
    ],
    runtime_deps = [
        ":jline_terminal"
    ],
    visibility = [
        "//visibility:public"
    ]
)

scala_import(
    name = "jline_terminal",
    jars = [
        "//external:jar/org/jline/jline_terminal"
    ],
    runtime_deps = [
        ":jline_native"
    ],
    visibility = [
        "//scala/3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "jline_terminal_jni",
    jars = [
        "//external:jar/org/jline/jline_terminal_jni"
    ],
    runtime_deps = [
        ":jline_native",
        ":jline_terminal"
    ],
    visibility = [
        "//scala/3rdparty/jvm:__subpackages__"
    ]
)
