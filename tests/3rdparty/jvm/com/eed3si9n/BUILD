load("@rules_scala3//rules:scala.bzl", "scala_import")
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
        "//3rdparty/jvm/net/openhft:zero_allocation_hashing",
        "//3rdparty/jvm/org/scala_lang:scala3_library"
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
