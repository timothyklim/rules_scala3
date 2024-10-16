load("@rules_scala3//rules:scala.bzl", "scala_import")

scala_import(
    name = "compiler_interface",
    jars = [
        "//external:jar/org/scala_sbt/compiler_interface",
    ],
    visibility = [
        "//visibility:public",
    ],
    runtime_deps = [
        ":util_interface",
    ],
)

scala_import(
    name = "io",
    jars = [
        "//external:jar/org/scala_sbt/io_3",
    ],
    visibility = [
        "//scala/3rdparty/jvm:__subpackages__",
    ],
    runtime_deps = [
        "//scala/3rdparty/jvm/com/swoval:file_tree_views",
        "//scala/3rdparty/jvm/net/java/dev/jna",
        "//scala/3rdparty/jvm/net/java/dev/jna:jna_platform",
        "//scala/3rdparty/jvm/org/scala_lang:scala3_library",
    ],
)

java_import(
    name = "launcher_interface",
    jars = [
        "//external:jar/org/scala_sbt/launcher_interface",
    ],
    visibility = [
        "//scala/3rdparty/jvm:__subpackages__",
    ],
)

scala_import(
    name = "sbinary",
    jars = [
        "//external:jar/org/scala_sbt/sbinary_3",
    ],
    visibility = [
        "//scala/3rdparty/jvm:__subpackages__",
    ],
    runtime_deps = [
        "//scala/3rdparty/jvm/org/scala_lang:scala3_library",
        "//scala/3rdparty/jvm/org/scala_lang/modules:scala_xml",
    ],
)

java_import(
    name = "test_interface",
    jars = [
        "//external:jar/org/scala_sbt/test_interface",
    ],
    visibility = [
        "//visibility:public",
    ],
)

scala_import(
    name = "util_control",
    jars = [
        "//external:jar/org/scala_sbt/util_control_3",
    ],
    visibility = [
        "//scala/3rdparty/jvm:__subpackages__",
    ],
    runtime_deps = [
        "//scala/3rdparty/jvm/org/scala_lang:scala3_library",
        "//scala/3rdparty/jvm/org/scala_lang/modules:scala_collection_compat",
    ],
)

scala_import(
    name = "util_core",
    jars = [
        "//external:jar/org/scala_sbt/util_core_3",
    ],
    visibility = [
        "//scala/3rdparty/jvm:__subpackages__",
    ],
    runtime_deps = [
        "//scala/3rdparty/jvm/org/scala_lang:scala3_library",
        "//scala/3rdparty/jvm/org/scala_lang/modules:scala_collection_compat",
    ],
)

java_import(
    name = "util_interface",
    jars = [
        "//external:jar/org/scala_sbt/util_interface",
    ],
    visibility = [
        "//visibility:public",
    ],
)

scala_import(
    name = "util_logging",
    jars = [
        "//external:jar/org/scala_sbt/util_logging_3",
    ],
    visibility = [
        "//visibility:public",
    ],
    runtime_deps = [
        ":io",
        ":util_core",
        ":util_interface",
        "//scala/3rdparty/jvm/com/eed3si9n:sjson_new_core",
        "//scala/3rdparty/jvm/com/eed3si9n:sjson_new_scalajson",
        "//scala/3rdparty/jvm/com/lmax:disruptor",
        "//scala/3rdparty/jvm/org/apache/logging/log4j:log4j_api",
        "//scala/3rdparty/jvm/org/apache/logging/log4j:log4j_core",
        "//scala/3rdparty/jvm/org/jline:jline_terminal",
        "//scala/3rdparty/jvm/org/jline:jline_terminal_jansi",
        "//scala/3rdparty/jvm/org/jline:jline_terminal_jna",
        "//scala/3rdparty/jvm/org/scala_lang:scala3_library",
        "//scala/3rdparty/jvm/org/scala_lang/modules:scala_collection_compat",
        "//scala/3rdparty/jvm/org/scala_sbt/jline",
    ],
)

scala_import(
    name = "util_relation",
    jars = [
        "//external:jar/org/scala_sbt/util_relation_3",
    ],
    visibility = [
        "//scala/3rdparty/jvm:__subpackages__",
    ],
    runtime_deps = [
        "//scala/3rdparty/jvm/org/scala_lang:scala3_library",
        "//scala/3rdparty/jvm/org/scala_lang/modules:scala_collection_compat",
    ],
)

scala_import(
    name = "zinc",
    jars = [
        "//external:jar/org/scala_sbt/zinc_3",
    ],
    visibility = [
        "//visibility:public",
    ],
    runtime_deps = [
        ":zinc_classfile",
        ":zinc_compile_core",
        ":zinc_core",
        ":zinc_persist",
        "//scala/3rdparty/jvm/org/scala_lang:scala3_library",
    ],
)

scala_import(
    name = "zinc_apiinfo",
    jars = [
        "//external:jar/org/scala_sbt/zinc_apiinfo_3",
    ],
    visibility = [
        "//visibility:public",
    ],
    runtime_deps = [
        ":compiler_interface",
        ":zinc_classfile",
        "//scala/3rdparty/jvm/org/scala_lang:scala3_library",
    ],
)

scala_import(
    name = "zinc_classfile",
    jars = [
        "//external:jar/org/scala_sbt/zinc_classfile_3",
    ],
    visibility = [
        "//scala/3rdparty/jvm:__subpackages__",
    ],
    runtime_deps = [
        ":compiler_interface",
        ":io",
        ":util_logging",
        "//scala/3rdparty/jvm/org/scala_lang:scala3_library",
    ],
)

scala_import(
    name = "zinc_classpath",
    jars = [
        "//external:jar/org/scala_sbt/zinc_classpath_3",
    ],
    visibility = [
        "//visibility:public",
    ],
    runtime_deps = [
        ":compiler_interface",
        ":io",
        ":launcher_interface",
        "//scala/3rdparty/jvm/org/scala_lang:scala3_library",
    ],
)

scala_import(
    name = "zinc_compile_core",
    jars = [
        "//external:jar/org/scala_sbt/zinc_compile_core_3",
    ],
    visibility = [
        "//visibility:public",
    ],
    runtime_deps = [
        ":compiler_interface",
        ":io",
        ":launcher_interface",
        ":util_control",
        ":util_logging",
        ":zinc_apiinfo",
        ":zinc_classfile",
        ":zinc_classpath",
        "//scala/3rdparty/jvm/net/openhft:zero_allocation_hashing",
        "//scala/3rdparty/jvm/org/scala_lang:scala3_library",
        "//scala/3rdparty/jvm/org/scala_lang/modules:scala_parser_combinators",
    ],
)

scala_import(
    name = "zinc_core",
    jars = [
        "//external:jar/org/scala_sbt/zinc_core_3",
    ],
    visibility = [
        "//visibility:public",
    ],
    runtime_deps = [
        ":compiler_interface",
        ":io",
        ":util_logging",
        ":util_relation",
        ":zinc_apiinfo",
        ":zinc_classpath",
        ":zinc_compile_core",
        ":zinc_persist_core_assembly",
        "//scala/3rdparty/jvm/org/scala_lang:scala3_library",
        "//scala/3rdparty/jvm/org/scala_lang:scala_reflect",
        "//scala/3rdparty/jvm/org/scala_lang/modules:scala_parallel_collections",
    ],
)

scala_import(
    name = "zinc_persist",
    jars = [
        "//external:jar/org/scala_sbt/zinc_persist_3",
    ],
    visibility = [
        "//visibility:public",
    ],
    runtime_deps = [
        ":sbinary",
        ":zinc_compile_core",
        ":zinc_core",
        ":zinc_persist_core_assembly",
        "//scala/3rdparty/jvm/org/scala_lang:scala3_library",
        "//scala/3rdparty/jvm/org/scala_lang/modules:scala_parallel_collections",
    ],
)

java_import(
    name = "zinc_persist_core_assembly",
    jars = [
        "//external:jar/org/scala_sbt/zinc_persist_core_assembly",
    ],
    visibility = [
        "//visibility:public",
    ],
)
