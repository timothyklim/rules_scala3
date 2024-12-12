load("@rules_scala3//rules:scala.bzl", "scala_import")
scala_import(
    name = "scalafix_cli",
    jars = [
        "//external:jar/ch/epfl/scala/scalafix_cli_3_5_1"
    ],
    runtime_deps = [
        "//3rdparty/jvm/com/martiansoftware:nailgun_server",
        "//3rdparty/jvm/org/apache/commons:commons_text",
        "//3rdparty/jvm/org/eclipse/jgit:org_eclipse_jgit",
        "//3rdparty/jvm/org/scala_lang:scala3_library",
        ":scalafix_interfaces",
        ":scalafix_reflect",
        ":scalafix_rules"
    ],
    visibility = [
        "//visibility:public"
    ]
)

scala_import(
    name = "scalafix_core",
    jars = [
        "//external:jar/ch/epfl/scala/scalafix_core_2_13"
    ],
    runtime_deps = [
        "//3rdparty/jvm/com/googlecode/java_diff_utils:diffutils",
        "//3rdparty/jvm/org/scala_lang/modules:scala_collection_compat",
        "//3rdparty/jvm/org/scala_lang:scala_library",
        "//3rdparty/jvm/org/scalameta:metaconfig_typesafe_config",
        "//3rdparty/jvm/org/scalameta:scalameta",
        "//3rdparty/jvm/org/scalameta:semanticdb_shared"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

java_import(
    name = "scalafix_interfaces",
    jars = [
        "//external:jar/ch/epfl/scala/scalafix_interfaces"
    ],
    runtime_deps = [
        "//3rdparty/jvm/io/get_coursier:interface"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "scalafix_reflect",
    jars = [
        "//external:jar/ch/epfl/scala/scalafix_reflect_2_13_15"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_lang:scala_compiler",
        "//3rdparty/jvm/org/scala_lang:scala_library",
        "//3rdparty/jvm/org/scala_lang:scala_reflect",
        "//3rdparty/jvm/org/scalameta:semanticdb_scalac_core",
        ":scalafix_core"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "scalafix_rules",
    jars = [
        "//external:jar/ch/epfl/scala/scalafix_rules_3_5_1"
    ],
    runtime_deps = [
        "//3rdparty/jvm/io/get_coursier:interface",
        "//3rdparty/jvm/org/scala_lang:scala3_library",
        "//3rdparty/jvm/org/scala_lang:scala3_presentation_compiler",
        ":scalafix_core"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)
