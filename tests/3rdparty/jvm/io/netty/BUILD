load("@rules_scala3//rules:scala.bzl", "scala_import")
java_import(
    name = "netty_buffer",
    jars = [
        "//external:jar/io/netty/netty_buffer"
    ],
    runtime_deps = [
        ":netty_common"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

java_import(
    name = "netty_codec",
    jars = [
        "//external:jar/io/netty/netty_codec"
    ],
    runtime_deps = [
        ":netty_buffer",
        ":netty_common",
        ":netty_transport"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

java_import(
    name = "netty_codec_http",
    jars = [
        "//external:jar/io/netty/netty_codec_http"
    ],
    runtime_deps = [
        ":netty_buffer",
        ":netty_codec",
        ":netty_common",
        ":netty_handler",
        ":netty_transport"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

java_import(
    name = "netty_codec_http2",
    jars = [
        "//external:jar/io/netty/netty_codec_http2"
    ],
    runtime_deps = [
        ":netty_buffer",
        ":netty_codec",
        ":netty_codec_http",
        ":netty_common",
        ":netty_handler",
        ":netty_transport"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

java_import(
    name = "netty_codec_socks",
    jars = [
        "//external:jar/io/netty/netty_codec_socks"
    ],
    runtime_deps = [
        ":netty_buffer",
        ":netty_codec",
        ":netty_common",
        ":netty_transport"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

java_import(
    name = "netty_common",
    jars = [
        "//external:jar/io/netty/netty_common"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

java_import(
    name = "netty_handler",
    jars = [
        "//external:jar/io/netty/netty_handler"
    ],
    runtime_deps = [
        ":netty_buffer",
        ":netty_codec",
        ":netty_common",
        ":netty_resolver",
        ":netty_transport",
        ":netty_transport_native_unix_common"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

java_import(
    name = "netty_handler_proxy",
    jars = [
        "//external:jar/io/netty/netty_handler_proxy"
    ],
    runtime_deps = [
        ":netty_buffer",
        ":netty_codec",
        ":netty_codec_http",
        ":netty_codec_socks",
        ":netty_common",
        ":netty_transport"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

java_import(
    name = "netty_resolver",
    jars = [
        "//external:jar/io/netty/netty_resolver"
    ],
    runtime_deps = [
        ":netty_common"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

java_import(
    name = "netty_transport",
    jars = [
        "//external:jar/io/netty/netty_transport"
    ],
    runtime_deps = [
        ":netty_buffer",
        ":netty_common",
        ":netty_resolver"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

java_import(
    name = "netty_transport_native_unix_common",
    jars = [
        "//external:jar/io/netty/netty_transport_native_unix_common"
    ],
    runtime_deps = [
        ":netty_buffer",
        ":netty_common",
        ":netty_transport"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)
