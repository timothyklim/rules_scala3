load("@rules_scala3//rules:scala.bzl", "scala_import")
scala_import(
    name = "scala3_compiler",
    jars = [
        "//external:jar/org/scala_lang/scala3_compiler_3"
    ],
    runtime_deps = [
        "//rules/scalafix/3rdparty/jvm/org/jline:jline_reader",
        "//rules/scalafix/3rdparty/jvm/org/jline:jline_terminal",
        "//rules/scalafix/3rdparty/jvm/org/jline:jline_terminal_jna",
        "//rules/scalafix/3rdparty/jvm/org/scala_lang/modules:scala_asm",
        "//rules/scalafix/3rdparty/jvm/org/scala_sbt:compiler_interface",
        ":scala3_interfaces",
        ":scala3_library",
        ":tasty_core"
    ],
    visibility = [
        "//rules/scalafix/3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "scala3_interfaces",
    jars = [
        "//external:jar/org/scala_lang/scala3_interfaces"
    ],
    visibility = [
        "//rules/scalafix/3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "scala3_library",
    exports = [
        "@scala3_library//jar"
    ],
    visibility = [
        "//rules/scalafix/3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "scala3_presentation_compiler",
    jars = [
        "//external:jar/org/scala_lang/scala3_presentation_compiler_3"
    ],
    runtime_deps = [
        "//rules/scalafix/3rdparty/jvm/io/get_coursier:interface",
        "//rules/scalafix/3rdparty/jvm/org/eclipse/lsp4j:org_eclipse_lsp4j",
        "//rules/scalafix/3rdparty/jvm/org/lz4:lz4_java",
        "//rules/scalafix/3rdparty/jvm/org/scalameta:mtags_interfaces",
        ":scala3_compiler",
        ":scala3_library"
    ],
    visibility = [
        "//rules/scalafix/3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "scala_compiler",
    jars = [
        "//external:jar/org/scala_lang/scala_compiler"
    ],
    runtime_deps = [
        "//rules/scalafix/3rdparty/jvm/io/github/java_diff_utils:java_diff_utils",
        "//rules/scalafix/3rdparty/jvm/net/java/dev/jna:jna",
        "//rules/scalafix/3rdparty/jvm/org/jline:jline",
        ":scala_library",
        ":scala_reflect"
    ],
    visibility = [
        "//rules/scalafix/3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "scala_library",
    exports = [
        "@scala_library_2_13//jar"
    ],
    visibility = [
        "//rules/scalafix/3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "scala_reflect",
    exports = [
        "@scala_reflect_2_13//jar"
    ],
    visibility = [
        "//rules/scalafix/3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "scalap",
    jars = [
        "//external:jar/org/scala_lang/scalap"
    ],
    runtime_deps = [
        ":scala_compiler"
    ],
    visibility = [
        "//rules/scalafix/3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "tasty_core",
    jars = [
        "//external:jar/org/scala_lang/tasty_core_3"
    ],
    runtime_deps = [
        ":scala3_library"
    ],
    visibility = [
        "//rules/scalafix/3rdparty/jvm:__subpackages__"
    ]
)
