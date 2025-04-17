load("@rules_scala3//rules:scala.bzl", "scala_import")
scala_import(
    name = "compiler_interface",
    jars = [
        "//external:jar/org/scala_sbt/compiler_interface"
    ],
    runtime_deps = [
        ":util_interface"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "io",
    jars = [
        "//external:jar/org/scala_sbt/io_3"
    ],
    runtime_deps = [
        "//3rdparty/jvm/com/swoval:file_tree_views",
        "//3rdparty/jvm/org/scala_lang:scala3_library"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "launcher_interface",
    jars = [
        "//external:jar/org/scala_sbt/launcher_interface"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "test_interface",
    jars = [
        "//external:jar/org/scala_sbt/test_interface"
    ],
    visibility = [
        "//visibility:public"
    ]
)

scala_import(
    name = "util_control",
    jars = [
        "//external:jar/org/scala_sbt/util_control_3"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_lang/modules:scala_collection_compat",
        "//3rdparty/jvm/org/scala_lang:scala3_library"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "util_core",
    jars = [
        "//external:jar/org/scala_sbt/util_core_3"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_lang:scala3_library"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "util_interface",
    jars = [
        "//external:jar/org/scala_sbt/util_interface"
    ],
    visibility = [
        "//visibility:public"
    ]
)

scala_import(
    name = "util_logging",
    jars = [
        "//external:jar/org/scala_sbt/util_logging_3"
    ],
    runtime_deps = [
        "//3rdparty/jvm/com/eed3si9n:sjson_new_core",
        "//3rdparty/jvm/com/eed3si9n:sjson_new_scalajson",
        "//3rdparty/jvm/com/lmax:disruptor",
        "//3rdparty/jvm/org/apache/logging/log4j:log4j_api",
        "//3rdparty/jvm/org/apache/logging/log4j:log4j_core",
        "//3rdparty/jvm/org/jline:jline_native",
        "//3rdparty/jvm/org/jline:jline_terminal",
        "//3rdparty/jvm/org/jline:jline_terminal_jni",
        "//3rdparty/jvm/org/scala_lang:scala3_library",
        "//3rdparty/jvm/org/scala_sbt/jline:jline",
        ":io",
        ":util_core",
        ":util_interface"
    ],
    visibility = [
        "//visibility:public"
    ]
)

scala_import(
    name = "zinc_apiinfo",
    jars = [
        "//external:jar/org/scala_sbt/zinc_apiinfo_3"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_lang:scala3_library",
        ":compiler_interface",
        ":zinc_classfile"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "zinc_classfile",
    jars = [
        "//external:jar/org/scala_sbt/zinc_classfile_3"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_lang:scala3_library",
        ":compiler_interface",
        ":io",
        ":util_logging"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "zinc_classpath",
    jars = [
        "//external:jar/org/scala_sbt/zinc_classpath_3"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_lang:scala3_library",
        ":compiler_interface",
        ":io",
        ":launcher_interface"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "zinc_compile_core",
    jars = [
        "//external:jar/org/scala_sbt/zinc_compile_core_3"
    ],
    runtime_deps = [
        "//3rdparty/jvm/net/openhft:zero_allocation_hashing",
        "//3rdparty/jvm/org/scala_lang/modules:scala_parser_combinators",
        "//3rdparty/jvm/org/scala_lang:scala3_library",
        ":compiler_interface",
        ":io",
        ":launcher_interface",
        ":util_control",
        ":util_logging",
        ":zinc_apiinfo",
        ":zinc_classfile",
        ":zinc_classpath"
    ],
    visibility = [
        "//visibility:public"
    ]
)
