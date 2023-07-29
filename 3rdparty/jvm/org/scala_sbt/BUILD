load("@rules_scala3//rules:scala.bzl", "scala_import")
scala_import(
    name = "collections",
    jars = [
        "//external:jar/org/scala_sbt/collections_3"
    ],
    runtime_deps = [
        "//3rdparty/jvm/com/eed3si9n:sjson_new_scalajson",
        "//3rdparty/jvm/org/scala_lang/modules:scala_parallel_collections",
        "//3rdparty/jvm/org/scala_lang:scala3_library",
        ":util_position"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "core_macros",
    jars = [
        "//external:jar/org/scala_sbt/core_macros_3"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_lang:scala3_library",
        ":collections"
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
        "//3rdparty/jvm/net/java/dev/jna:jna",
        "//3rdparty/jvm/net/java/dev/jna:jna_platform",
        "//3rdparty/jvm/org/scala_lang:scala3_library"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

java_import(
    name = "launcher_interface",
    jars = [
        "//external:jar/org/scala_sbt/launcher_interface"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "librarymanagement_core",
    jars = [
        "//external:jar/org/scala_sbt/librarymanagement_core_3"
    ],
    runtime_deps = [
        "//3rdparty/jvm/com/eed3si9n:gigahorse_okhttp",
        "//3rdparty/jvm/com/jcraft:jsch",
        "//3rdparty/jvm/com/squareup/okhttp3:okhttp_urlconnection",
        "//3rdparty/jvm/org/scala_lang/modules:scala_xml",
        "//3rdparty/jvm/org/scala_lang:scala3_library",
        ":io",
        ":launcher_interface",
        ":util_cache",
        ":util_logging",
        ":util_position"
    ],
    visibility = [
        "//visibility:public"
    ]
)

scala_import(
    name = "librarymanagement_coursier",
    jars = [
        "//external:jar/org/scala_sbt/librarymanagement_coursier_3"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_lang:scala3_library"
    ],
    visibility = [
        "//visibility:public"
    ]
)

scala_import(
    name = "util_cache",
    jars = [
        "//external:jar/org/scala_sbt/util_cache_3"
    ],
    runtime_deps = [
        "//3rdparty/jvm/com/eed3si9n:sjson_new_murmurhash",
        "//3rdparty/jvm/com/eed3si9n:sjson_new_scalajson",
        "//3rdparty/jvm/org/scala_lang:scala3_library",
        "//3rdparty/jvm/org/scala_lang:scala_reflect",
        ":io"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

java_import(
    name = "util_interface",
    jars = [
        "//external:jar/org/scala_sbt/util_interface"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
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
        "//3rdparty/jvm/org/jline:jline_terminal",
        "//3rdparty/jvm/org/jline:jline_terminal_jansi",
        "//3rdparty/jvm/org/jline:jline_terminal_jna",
        "//3rdparty/jvm/org/scala_lang:scala3_library",
        "//3rdparty/jvm/org/scala_sbt/jline:jline",
        ":collections",
        ":core_macros",
        ":io",
        ":util_interface"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "util_position",
    jars = [
        "//external:jar/org/scala_sbt/util_position_3"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_lang:scala3_library",
        "//3rdparty/jvm/org/scala_lang:scala_reflect"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)
