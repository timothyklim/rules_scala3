load("@rules_scala3//rules:scala.bzl", "scala_import")
java_import(
    name = "org_eclipse_xtend_lib",
    jars = [
        "//external:jar/org/eclipse/xtend/org_eclipse_xtend_lib"
    ],
    runtime_deps = [
        "//rules/scalafix/3rdparty/jvm/org/eclipse/xtext:org_eclipse_xtext_xbase_lib",
        ":org_eclipse_xtend_lib_macro"
    ],
    visibility = [
        "//rules/scalafix/3rdparty/jvm:__subpackages__"
    ]
)

java_import(
    name = "org_eclipse_xtend_lib_macro",
    jars = [
        "//external:jar/org/eclipse/xtend/org_eclipse_xtend_lib_macro"
    ],
    runtime_deps = [
        "//rules/scalafix/3rdparty/jvm/org/eclipse/xtext:org_eclipse_xtext_xbase_lib"
    ],
    visibility = [
        "//rules/scalafix/3rdparty/jvm:__subpackages__"
    ]
)
