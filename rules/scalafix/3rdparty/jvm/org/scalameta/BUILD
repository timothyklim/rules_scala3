load("@rules_scala3//rules:scala.bzl", "scala_import")
scala_import(
    name = "common",
    jars = [
        "//external:jar/org/scalameta/common_2_13"
    ],
    runtime_deps = [
        "//rules/scalafix/3rdparty/jvm/com/lihaoyi:sourcecode",
        "//rules/scalafix/3rdparty/jvm/org/scala_lang:scala_library"
    ],
    visibility = [
        "//rules/scalafix/3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "metaconfig_core",
    jars = [
        "//external:jar/org/scalameta/metaconfig_core_2_13"
    ],
    runtime_deps = [
        "//rules/scalafix/3rdparty/jvm/org/scala_lang/modules:scala_collection_compat",
        "//rules/scalafix/3rdparty/jvm/org/scala_lang:scala_library",
        "//rules/scalafix/3rdparty/jvm/org/scala_lang:scala_reflect",
        "//rules/scalafix/3rdparty/jvm/org/typelevel:paiges_core",
        ":metaconfig_pprint"
    ],
    visibility = [
        "//rules/scalafix/3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "metaconfig_pprint",
    jars = [
        "//external:jar/org/scalameta/metaconfig_pprint_2_13"
    ],
    runtime_deps = [
        "//rules/scalafix/3rdparty/jvm/com/lihaoyi:fansi",
        "//rules/scalafix/3rdparty/jvm/org/scala_lang:scala_compiler",
        "//rules/scalafix/3rdparty/jvm/org/scala_lang:scala_library",
        "//rules/scalafix/3rdparty/jvm/org/scala_lang:scala_reflect"
    ],
    visibility = [
        "//rules/scalafix/3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "metaconfig_typesafe_config",
    jars = [
        "//external:jar/org/scalameta/metaconfig_typesafe_config_2_13"
    ],
    runtime_deps = [
        "//rules/scalafix/3rdparty/jvm/com/typesafe:config",
        "//rules/scalafix/3rdparty/jvm/org/scala_lang:scala_library",
        ":metaconfig_core"
    ],
    visibility = [
        "//rules/scalafix/3rdparty/jvm:__subpackages__"
    ]
)

java_import(
    name = "mtags_interfaces",
    jars = [
        "//external:jar/org/scalameta/mtags_interfaces"
    ],
    visibility = [
        "//rules/scalafix/3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "parsers",
    jars = [
        "//external:jar/org/scalameta/parsers_2_13"
    ],
    runtime_deps = [
        "//rules/scalafix/3rdparty/jvm/org/scala_lang:scala_library",
        ":trees"
    ],
    visibility = [
        "//rules/scalafix/3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "scalameta",
    jars = [
        "//external:jar/org/scalameta/scalameta_2_13"
    ],
    runtime_deps = [
        "//rules/scalafix/3rdparty/jvm/org/scala_lang:scala_library",
        "//rules/scalafix/3rdparty/jvm/org/scala_lang:scalap",
        ":parsers"
    ],
    visibility = [
        "//rules/scalafix/3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "semanticdb_scalac",
    jars = [
        "//external:jar/org/scalameta/semanticdb_scalac_2_13_15"
    ],
    runtime_deps = [
        "//rules/scalafix/3rdparty/jvm/org/scala_lang:scala_library"
    ],
    visibility = [
        "//visibility:public"
    ]
)

scala_import(
    name = "semanticdb_scalac_core",
    jars = [
        "//external:jar/org/scalameta/semanticdb_scalac_core_2_13_15"
    ],
    runtime_deps = [
        "//rules/scalafix/3rdparty/jvm/org/scala_lang:scala_compiler",
        "//rules/scalafix/3rdparty/jvm/org/scala_lang:scala_library",
        ":semanticdb_shared"
    ],
    visibility = [
        "//rules/scalafix/3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "semanticdb_shared",
    jars = [
        "//external:jar/org/scalameta/semanticdb_shared_2_13"
    ],
    runtime_deps = [
        "//rules/scalafix/3rdparty/jvm/com/thesamet/scalapb:scalapb_runtime",
        "//rules/scalafix/3rdparty/jvm/org/scala_lang:scala_library",
        ":scalameta"
    ],
    visibility = [
        "//rules/scalafix/3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "trees",
    jars = [
        "//external:jar/org/scalameta/trees_2_13"
    ],
    runtime_deps = [
        "//rules/scalafix/3rdparty/jvm/org/scala_lang:scala_library",
        ":common"
    ],
    visibility = [
        "//rules/scalafix/3rdparty/jvm:__subpackages__"
    ]
)
