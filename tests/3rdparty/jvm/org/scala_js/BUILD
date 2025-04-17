load("@rules_scala3//rules:scala.bzl", "scala_import")
scala_import(
    name = "scalajs_dom_sjs1",
    jars = [
        "//external:jar/org/scala_js/scalajs_dom_sjs1_3"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_lang:scala3_library_sjs1",
        ":scalajs_library"
    ],
    visibility = [
        "//visibility:public"
    ]
)

scala_import(
    name = "scalajs_javalib",
    jars = [
        "//external:jar/org/scala_js/scalajs_javalib"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)

scala_import(
    name = "scalajs_library",
    jars = [
        "//external:jar/org/scala_js/scalajs_library_2_13"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_lang:scala_library",
        ":scalajs_javalib",
        ":scalajs_scalalib"
    ],
    visibility = [
        "//visibility:public"
    ]
)

scala_import(
    name = "scalajs_scalalib",
    jars = [
        "//external:jar/org/scala_js/scalajs_scalalib_2_13"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_lang:scala_library",
        ":scalajs_javalib"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)
