load("@rules_scala3//rules:scala.bzl", "scala_import")
java_import(
    name = "grpc_api",
    jars = [
        "//external:jar/io/grpc/grpc_api"
    ],
    runtime_deps = [
        "//3rdparty/jvm/com/google/code/findbugs:jsr305",
        "//3rdparty/jvm/com/google/errorprone:error_prone_annotations",
        "//3rdparty/jvm/com/google/guava:guava"
    ],
    visibility = [
        "//visibility:public"
    ]
)

java_import(
    name = "grpc_protobuf",
    jars = [
        "//external:jar/io/grpc/grpc_protobuf"
    ],
    runtime_deps = [
        "//3rdparty/jvm/com/google/api/grpc:proto_google_common_protos",
        "//3rdparty/jvm/com/google/code/findbugs:jsr305",
        "//3rdparty/jvm/com/google/guava:guava",
        "//3rdparty/jvm/com/google/protobuf:protobuf_java",
        ":grpc_api",
        ":grpc_protobuf_lite"
    ],
    visibility = [
        "//visibility:public"
    ]
)

java_import(
    name = "grpc_protobuf_lite",
    jars = [
        "//external:jar/io/grpc/grpc_protobuf_lite"
    ],
    runtime_deps = [
        "//3rdparty/jvm/com/google/code/findbugs:jsr305",
        "//3rdparty/jvm/com/google/guava:guava",
        ":grpc_api"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

java_import(
    name = "grpc_stub",
    jars = [
        "//external:jar/io/grpc/grpc_stub"
    ],
    runtime_deps = [
        "//3rdparty/jvm/com/google/errorprone:error_prone_annotations",
        "//3rdparty/jvm/com/google/guava:guava",
        ":grpc_api"
    ],
    visibility = [
        "//visibility:public"
    ]
)
