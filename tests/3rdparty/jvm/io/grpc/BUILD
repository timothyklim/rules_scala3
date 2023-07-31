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
        "//3rdparty/jvm:__subpackages__"
    ]
)

java_import(
    name = "grpc_context",
    jars = [
        "//external:jar/io/grpc/grpc_context"
    ],
    runtime_deps = [
        ":grpc_api"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

java_import(
    name = "grpc_core",
    jars = [
        "//external:jar/io/grpc/grpc_core"
    ],
    runtime_deps = [
        "//3rdparty/jvm/com/google/android:annotations",
        "//3rdparty/jvm/com/google/code/gson:gson",
        "//3rdparty/jvm/com/google/errorprone:error_prone_annotations",
        "//3rdparty/jvm/com/google/guava:guava",
        "//3rdparty/jvm/io/perfmark:perfmark_api",
        "//3rdparty/jvm/org/codehaus/mojo:animal_sniffer_annotations",
        ":grpc_api",
        ":grpc_context"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

java_import(
    name = "grpc_netty",
    jars = [
        "//external:jar/io/grpc/grpc_netty"
    ],
    runtime_deps = [
        "//3rdparty/jvm/com/google/errorprone:error_prone_annotations",
        "//3rdparty/jvm/com/google/guava:guava",
        "//3rdparty/jvm/io/netty:netty_codec_http2",
        "//3rdparty/jvm/io/netty:netty_handler_proxy",
        "//3rdparty/jvm/io/netty:netty_transport_native_unix_common",
        "//3rdparty/jvm/io/perfmark:perfmark_api",
        ":grpc_core"
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
        "//3rdparty/jvm:__subpackages__"
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
        "//3rdparty/jvm:__subpackages__"
    ]
)
