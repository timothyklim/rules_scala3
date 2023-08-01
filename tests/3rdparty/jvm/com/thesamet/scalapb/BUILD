load("@rules_scala3//rules:scala.bzl", "scala_import")
scala_import(
    name = "lenses",
    jars = [
        "//external:jar/com/thesamet/scalapb/lenses_3"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_lang/modules:scala_collection_compat",
        "//3rdparty/jvm/org/scala_lang:scala3_library"
    ],
    visibility = [
        "//visibility:public"
    ]
)

scala_import(
    name = "lenses_sjs1",
    jars = [
        "//external:jar/com/thesamet/scalapb/lenses_sjs1_3"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_js:scalajs_library",
        "//3rdparty/jvm/org/scala_lang/modules:scala_collection_compat_sjs1",
        "//3rdparty/jvm/org/scala_lang:scala3_library_sjs1"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "protobuf_runtime_scala_sjs1",
    jars = [
        "//external:jar/com/thesamet/scalapb/protobuf_runtime_scala_sjs1_3"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_js:scalajs_library",
        "//3rdparty/jvm/org/scala_lang:scala3_library_sjs1"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "scalapb_runtime",
    jars = [
        "//external:jar/com/thesamet/scalapb/scalapb_runtime_3"
    ],
    runtime_deps = [
        "//3rdparty/jvm/com/google/protobuf:protobuf_java",
        "//3rdparty/jvm/org/scala_lang/modules:scala_collection_compat",
        "//3rdparty/jvm/org/scala_lang:scala3_library",
        ":lenses"
    ],
    visibility = [
        "//visibility:public"
    ]
)

scala_import(
    name = "scalapb_runtime_grpc",
    jars = [
        "//external:jar/com/thesamet/scalapb/scalapb_runtime_grpc_3"
    ],
    runtime_deps = [
        "//3rdparty/jvm/io/grpc:grpc_protobuf",
        "//3rdparty/jvm/io/grpc:grpc_stub",
        "//3rdparty/jvm/org/scala_lang/modules:scala_collection_compat",
        "//3rdparty/jvm/org/scala_lang:scala3_library",
        ":scalapb_runtime"
    ],
    visibility = [
        "//visibility:public"
    ]
)

scala_import(
    name = "scalapb_runtime_sjs1",
    jars = [
        "//external:jar/com/thesamet/scalapb/scalapb_runtime_sjs1_3"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_js:scalajs_library",
        "//3rdparty/jvm/org/scala_lang/modules:scala_collection_compat_sjs1",
        "//3rdparty/jvm/org/scala_lang:scala3_library_sjs1",
        ":lenses_sjs1",
        ":protobuf_runtime_scala_sjs1"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)
