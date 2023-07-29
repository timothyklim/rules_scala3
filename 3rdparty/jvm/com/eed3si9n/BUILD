load("@rules_scala3//rules:scala.bzl", "scala_import")
scala_import(
    name = "gigahorse_core",
    jars = [
        "//external:jar/com/eed3si9n/gigahorse_core_3"
    ],
    runtime_deps = [
        "//3rdparty/jvm/com/typesafe:ssl_config_core",
        "//3rdparty/jvm/org/reactivestreams:reactive_streams",
        "//3rdparty/jvm/org/scala_lang:scala3_library",
        "//3rdparty/jvm/org/slf4j:slf4j_api"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "gigahorse_okhttp",
    jars = [
        "//external:jar/com/eed3si9n/gigahorse_okhttp_3"
    ],
    runtime_deps = [
        "//3rdparty/jvm/com/squareup/okhttp3:okhttp",
        "//3rdparty/jvm/org/scala_lang:scala3_library",
        ":gigahorse_core"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "shaded_jawn_parser",
    jars = [
        "//external:jar/com/eed3si9n/shaded_jawn_parser_3"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_lang:scala3_library"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "shaded_scalajson",
    jars = [
        "//external:jar/com/eed3si9n/shaded_scalajson_3"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_lang:scala3_library"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "sjson_new_core",
    jars = [
        "//external:jar/com/eed3si9n/sjson_new_core_3"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_lang:scala3_library"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "sjson_new_murmurhash",
    jars = [
        "//external:jar/com/eed3si9n/sjson_new_murmurhash_3"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_lang:scala3_library",
        ":sjson_new_core"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "sjson_new_scalajson",
    jars = [
        "//external:jar/com/eed3si9n/sjson_new_scalajson_3"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_lang:scala3_library",
        ":shaded_jawn_parser",
        ":shaded_scalajson",
        ":sjson_new_core"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)
