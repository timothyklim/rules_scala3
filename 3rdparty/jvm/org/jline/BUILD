load("@rules_scala3//rules:scala.bzl", "scala_import")
java_import(
    name = "jline",
    jars = [
        "//external:jar/org/jline/jline"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

java_import(
    name = "jline_native",
    jars = [
        "//external:jar/org/jline/jline_native"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

java_import(
    name = "jline_reader",
    jars = [
        "//external:jar/org/jline/jline_reader"
    ],
    runtime_deps = [
        ":jline_terminal"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

java_import(
    name = "jline_terminal",
    jars = [
        "//external:jar/org/jline/jline_terminal"
    ],
    runtime_deps = [
        ":jline_native"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

java_import(
    name = "jline_terminal_jna",
    jars = [
        "//external:jar/org/jline/jline_terminal_jna"
    ],
    runtime_deps = [
        "//3rdparty/jvm/net/java/dev/jna:jna",
        ":jline_terminal"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)
