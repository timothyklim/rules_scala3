load("@rules_scala3//rules:scala.bzl", "scala_import")

scala_import(
    name = "metaconfig_core",
    jars = [
        "//external:jar/com/geirsson/metaconfig_core_2_13",
    ],
    visibility = [
        "//visibility:public",
    ],
    runtime_deps = [
        ":metaconfig_pprint",
        "//rules/scalafmt/3rdparty/jvm/org/scala_lang:scala_library",
        "//rules/scalafmt/3rdparty/jvm/org/scala_lang:scala_reflect",
        "//rules/scalafmt/3rdparty/jvm/org/scala_lang/modules:scala_collection_compat",
        "//rules/scalafmt/3rdparty/jvm/org/typelevel:paiges_core",
    ],
)

scala_import(
    name = "metaconfig_pprint",
    jars = [
        "//external:jar/com/geirsson/metaconfig_pprint_2_13",
    ],
    visibility = [
        "//rules/scalafmt/3rdparty/jvm:__subpackages__",
    ],
    runtime_deps = [
        "//rules/scalafmt/3rdparty/jvm/com/lihaoyi:fansi",
        "//rules/scalafmt/3rdparty/jvm/org/scala_lang:scala_compiler",
        "//rules/scalafmt/3rdparty/jvm/org/scala_lang:scala_library",
        "//rules/scalafmt/3rdparty/jvm/org/scala_lang:scala_reflect",
    ],
)

scala_import(
    name = "metaconfig_typesafe_config",
    jars = [
        "//external:jar/com/geirsson/metaconfig_typesafe_config_2_13",
    ],
    visibility = [
        "//rules/scalafmt/3rdparty/jvm:__subpackages__",
    ],
    runtime_deps = [
        ":metaconfig_core",
        "//rules/scalafmt/3rdparty/jvm/com/typesafe:config",
        "//rules/scalafmt/3rdparty/jvm/org/scala_lang:scala_library",
    ],
)
