load("@rules_scala3//rules:scala.bzl", "scala_import")
scala_import(
    name = "failureaccess",
    jars = [
        "//external:jar/com/google/guava/failureaccess"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "guava",
    jars = [
        "//external:jar/com/google/guava/guava"
    ],
    runtime_deps = [
        "//3rdparty/jvm/com/google/code/findbugs:jsr305",
        "//3rdparty/jvm/com/google/errorprone:error_prone_annotations",
        "//3rdparty/jvm/com/google/j2objc:j2objc_annotations",
        "//3rdparty/jvm/org/checkerframework:checker_qual",
        ":failureaccess",
        ":listenablefuture"
    ],
    visibility = [
        "//visibility:public"
    ]
)

scala_import(
    name = "listenablefuture",
    jars = [
        "//external:jar/com/google/guava/listenablefuture"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)
