load("@rules_scala3//rules:scala.bzl", "scala_import")
scala_import(
    name = "compilerplugin",
    jars = [
        "//external:jar/com/thesamet/scalapb/compilerplugin_3"
    ],
    runtime_deps = [
        "//rules/scala_proto/3rdparty/jvm/com/google/protobuf:protobuf_java",
        "//rules/scala_proto/3rdparty/jvm/org/scala_lang/modules:scala_collection_compat",
        "//rules/scala_proto/3rdparty/jvm/org/scala_lang:scala3_library",
        ":protoc_gen"
    ],
    visibility = [
        "//visibility:public"
    ]
)

scala_import(
    name = "protoc_bridge",
    jars = [
        "//external:jar/com/thesamet/scalapb/protoc_bridge_2_13"
    ],
    runtime_deps = [
        "//rules/scala_proto/3rdparty/jvm/dev/dirs:directories",
        "//rules/scala_proto/3rdparty/jvm/org/scala_lang:scala_library"
    ],
    visibility = [
        "//visibility:public"
    ]
)

scala_import(
    name = "protoc_gen",
    jars = [
        "//external:jar/com/thesamet/scalapb/protoc_gen_2_13"
    ],
    runtime_deps = [
        "//rules/scala_proto/3rdparty/jvm/org/scala_lang:scala_library",
        ":protoc_bridge"
    ],
    visibility = [
        "//visibility:public"
    ]
)
