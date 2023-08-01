load("@rules_scala3//rules:scala.bzl", "scaladoc")

scaladoc(
    name = "a_doc",
    srcs = [
        "A.scala",
        "B.scala",
    ],
    compiler_deps = [
        "//3rdparty/jvm/org/scala_lang/modules:scala_xml",
    ],
    scala = "//scala:2_13",
    deps = [
        "//mockutil:mocklib",
    ],
)
