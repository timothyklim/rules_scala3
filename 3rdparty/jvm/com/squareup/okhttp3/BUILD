load("@rules_scala3//rules:scala.bzl", "scala_import")
java_import(
    name = "okhttp",
    jars = [
        "//external:jar/com/squareup/okhttp3/okhttp"
    ],
    runtime_deps = [
        "//3rdparty/jvm/com/squareup/okio:okio"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

java_import(
    name = "okhttp_urlconnection",
    jars = [
        "//external:jar/com/squareup/okhttp3/okhttp_urlconnection"
    ],
    runtime_deps = [
        ":okhttp"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)
