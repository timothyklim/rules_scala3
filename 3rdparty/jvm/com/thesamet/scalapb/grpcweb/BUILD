load("@rules_scala3//rules:scala.bzl", "scala_import")
scala_import(
    name = "scalapb_grpcweb_code_gen",
    jars = [
        "//external:jar/com/thesamet/scalapb/grpcweb/scalapb_grpcweb_code_gen_3"
    ],
    runtime_deps = [
        "//3rdparty/jvm/com/thesamet/scalapb:compilerplugin",
        "//3rdparty/jvm/org/scala_lang:scala3_library"
    ],
    visibility = [
        "//visibility:public"
    ]
)
