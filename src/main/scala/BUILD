load(
    "@rules_scala_annex//rules:scala.bzl",
    "configure_bootstrap_scala",
    "configure_zinc_scala",
    "scala_library",
)

alias(
    name = "bootstrap",
    actual = ":bootstrap_2_13_3",
    visibility = ["//visibility:public"],
)

alias(
    name = "zinc",
    actual = ":zinc_2_13",
    visibility = ["//visibility:public"],
)

alias(
    name = "2_13",
    actual = ":zinc_2_13",
    visibility = ["//visibility:public"],
)

compiler_classpath_2_13_3 = [
    "@annex//:org_scala_lang_scala_compiler",
    "@annex//:org_scala_lang_scala_library",
    "@annex//:org_scala_lang_scala_reflect",
]

runtime_classpath_2_13_3 = [
    "@annex//:org_scala_lang_scala_library",
]

configure_bootstrap_scala(
    name = "bootstrap_2_13_3",
    compiler_classpath = compiler_classpath_2_13_3,
    runtime_classpath = runtime_classpath_2_13_3,
    version = "2.13.3",
    visibility = ["//visibility:public"],
)

scala_library(
    name = "compiler_bridge_2_13_3",
    srcs = [
        "@compiler_bridge_2_13//:src",
    ],
    scala = ":bootstrap_2_13_3",
    resources = ["@compiler_bridge_2_13//:meta"],
    resource_strip_prefix = "../compiler_bridge_2_13",
    visibility = ["//visibility:public"],
    deps = compiler_classpath_2_13_3 + [
        "@annex//:org_scala_sbt_compiler_interface",
        "@annex//:org_scala_sbt_util_interface",
    ],
)

configure_zinc_scala(
    name = "zinc_2_13",
    compiler_bridge = ":compiler_bridge_2_13_3",
    compiler_classpath = compiler_classpath_2_13_3,
    runtime_classpath = runtime_classpath_2_13_3,
    version = "2.13.3",
    visibility = ["//visibility:public"],
)

config_setting(
    name = "deps_used_off",
    define_values = {
        "scala_deps_used": "off",
    },
)

config_setting(
    name = "deps_direct_off",
    define_values = {
        "scala_deps_direct": "off",
    },
)

# Scala 3.0.0-M1

alias(
    name = "3_0",
    actual = ":zinc_3_0",
    visibility = ["//visibility:public"],
)

compiler_classpath_3_0 = [
    "@scala_compiler_3_0_0_M1//jar",
    "@scala_library_3_0_0_M1//jar",
    "@scala_interfaces_3_0_0_M1//jar",
    "@scala_tasty_core_3_0_0_M1//jar",
    "@scala_asm_7_3_1//jar",
    "@scala_library_2_13_3//jar",
]

runtime_classpath_3_0 = [
    "@scala_library_3_0_0_M1//jar",
    "@scala_library_2_13_3//jar",
]

configure_zinc_scala(
    name = "zinc_3_0",
    compiler_bridge = "@scala_sbt_bridge_3_0_0_M1//jar",
    compiler_classpath = compiler_classpath_3_0,
    runtime_classpath = runtime_classpath_3_0,
    log_level = "debug",
    version = "3.0.0-M1",
    visibility = ["//visibility:public"],
)
