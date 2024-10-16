load("@rules_scala3//rules:scala.bzl", "scala_import")
scala_import(
    name = "common",
    jars = [
        "//external:jar/org/scalameta/common_2_13"
    ],
    runtime_deps = [
        "//rules/scalafmt/3rdparty/jvm/com/lihaoyi:sourcecode",
        "//rules/scalafmt/3rdparty/jvm/com/thesamet/scalapb:scalapb_runtime",
        "//rules/scalafmt/3rdparty/jvm/org/scala_lang:scala_library"
    ],
    visibility = [
        "//rules/scalafmt/3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "fastparse_v2",
    jars = [
        "//external:jar/org/scalameta/fastparse_v2_2_13"
    ],
    runtime_deps = [
        "//rules/scalafmt/3rdparty/jvm/com/lihaoyi:geny",
        "//rules/scalafmt/3rdparty/jvm/com/lihaoyi:sourcecode"
    ],
    visibility = [
        "//rules/scalafmt/3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "parsers",
    jars = [
        "//external:jar/org/scalameta/parsers_2_13"
    ],
    runtime_deps = [
        "//rules/scalafmt/3rdparty/jvm/org/scala_lang:scala_library",
        ":trees"
    ],
    visibility = [
        "//visibility:public"
    ]
)

scala_import(
    name = "scalafmt_config",
    jars = [
        "//external:jar/org/scalameta/scalafmt_config_2_13"
    ],
    runtime_deps = [
        "//rules/scalafmt/3rdparty/jvm/com/geirsson:metaconfig_core",
        "//rules/scalafmt/3rdparty/jvm/com/geirsson:metaconfig_typesafe_config",
        "//rules/scalafmt/3rdparty/jvm/org/scala_lang:scala_library"
    ],
    visibility = [
        "//rules/scalafmt/3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "scalafmt_core",
    jars = [
        "//external:jar/org/scalameta/scalafmt_core_2_13"
    ],
    runtime_deps = [
        "//rules/scalafmt/3rdparty/jvm/org/scala_lang:scala_library",
        "//rules/scalafmt/3rdparty/jvm/org/scala_lang:scala_reflect",
        ":scalafmt_config",
        ":scalafmt_sysops",
        ":scalameta"
    ],
    visibility = [
        "//visibility:public"
    ]
)

scala_import(
    name = "scalafmt_sysops",
    jars = [
        "//external:jar/org/scalameta/scalafmt_sysops_2_13"
    ],
    runtime_deps = [
        "//rules/scalafmt/3rdparty/jvm/org/scala_lang/modules:scala_parallel_collections",
        "//rules/scalafmt/3rdparty/jvm/org/scala_lang:scala_library"
    ],
    visibility = [
        "//rules/scalafmt/3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "scalameta",
    jars = [
        "//external:jar/org/scalameta/scalameta_2_13"
    ],
    runtime_deps = [
        "//rules/scalafmt/3rdparty/jvm/org/scala_lang:scala_library",
        "//rules/scalafmt/3rdparty/jvm/org/scala_lang:scalap",
        ":parsers"
    ],
    visibility = [
        "//rules/scalafmt/3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "trees",
    jars = [
        "//external:jar/org/scalameta/trees_2_13"
    ],
    runtime_deps = [
        "//rules/scalafmt/3rdparty/jvm/org/scala_lang:scala_library",
        ":common",
        ":fastparse_v2"
    ],
    visibility = [
        "//rules/scalafmt/3rdparty/jvm:__subpackages__"
    ]
)
