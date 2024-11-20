load("@rules_scala3//rules:scala.bzl", "scala_import")
java_import(
    name = "org_eclipse_lsp4j",
    jars = [
        "//external:jar/org/eclipse/lsp4j/org_eclipse_lsp4j"
    ],
    runtime_deps = [
        ":org_eclipse_lsp4j_generator",
        ":org_eclipse_lsp4j_jsonrpc"
    ],
    visibility = [
        "//rules/scalafix/3rdparty/jvm:__subpackages__"
    ]
)

java_import(
    name = "org_eclipse_lsp4j_generator",
    jars = [
        "//external:jar/org/eclipse/lsp4j/org_eclipse_lsp4j_generator"
    ],
    runtime_deps = [
        "//rules/scalafix/3rdparty/jvm/org/eclipse/xtend:org_eclipse_xtend_lib",
        ":org_eclipse_lsp4j_jsonrpc"
    ],
    visibility = [
        "//rules/scalafix/3rdparty/jvm:__subpackages__"
    ]
)

java_import(
    name = "org_eclipse_lsp4j_jsonrpc",
    jars = [
        "//external:jar/org/eclipse/lsp4j/org_eclipse_lsp4j_jsonrpc"
    ],
    runtime_deps = [
        "//rules/scalafix/3rdparty/jvm/com/google/code/gson:gson"
    ],
    visibility = [
        "//rules/scalafix/3rdparty/jvm:__subpackages__"
    ]
)
