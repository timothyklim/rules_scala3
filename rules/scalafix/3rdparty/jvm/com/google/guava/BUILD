load("@rules_scala3//rules:scala.bzl", "scala_import")
java_import(
    name = "failureaccess",
    jars = [
        "//external:jar/com/google/guava/failureaccess"
    ],
    visibility = [
        "//rules/scalafix/3rdparty/jvm:__subpackages__"
    ]
)

java_import(
    name = "guava",
    jars = [
        "//external:jar/com/google/guava/guava"
    ],
    runtime_deps = [
        "//rules/scalafix/3rdparty/jvm/com/google/code/findbugs:jsr305",
        "//rules/scalafix/3rdparty/jvm/com/google/errorprone:error_prone_annotations",
        "//rules/scalafix/3rdparty/jvm/com/google/j2objc:j2objc_annotations",
        "//rules/scalafix/3rdparty/jvm/org/checkerframework:checker_qual",
        ":failureaccess",
        ":listenablefuture"
    ],
    visibility = [
        "//rules/scalafix/3rdparty/jvm:__subpackages__"
    ]
)

java_import(
    name = "listenablefuture",
    jars = [
        "//external:jar/com/google/guava/listenablefuture"
    ],
    visibility = [
        "//rules/scalafix/3rdparty/jvm:__subpackages__"
    ]
)
