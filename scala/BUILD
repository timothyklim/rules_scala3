load(
    "@rules_scala3//rules:scala.bzl",
    "configure_bootstrap_scala",
    "configure_zinc_scala",
    "scala_library",
)

alias(
    name = "bootstrap",
    actual = ":bootstrap_2_13_5",
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

compiler_classpath_2_13_5 = [
    "@annex//:org_scala_lang_scala_compiler",
    "@annex//:org_scala_lang_scala_library",
    "@annex//:org_scala_lang_scala_reflect",
]

runtime_classpath_2_13_5 = [
    "@annex//:org_scala_lang_scala_library",
]

configure_bootstrap_scala(
    name = "bootstrap_2_13_5",
    compiler_classpath = compiler_classpath_2_13_5,
    runtime_classpath = runtime_classpath_2_13_5,
    version = "2.13.5",
    visibility = ["//visibility:public"],
)

scala_library(
    name = "compiler_bridge_2_13_5",
    srcs = [
        "@compiler_bridge_2_13//:src",
    ],
    resource_strip_prefix = "../compiler_bridge_2_13",
    resources = ["@compiler_bridge_2_13//:meta"],
    scala = ":bootstrap_2_13_5",
    visibility = ["//visibility:public"],
    deps = compiler_classpath_2_13_5 + [
        "@annex//:org_scala_sbt_compiler_interface",
        "@annex//:org_scala_sbt_util_interface",
    ],
)

configure_zinc_scala(
    name = "zinc_2_13",
    compiler_bridge = ":compiler_bridge_2_13_5",
    compiler_classpath = compiler_classpath_2_13_5,
    runtime_classpath = runtime_classpath_2_13_5,
    version = "2.13.5",
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

# Scala 3.0.0-RC2

scala3_version = "3.0.0-RC2"

scala3_global_scalacopts = [
    "-deprecation",
    "-unchecked",
    "-feature",
    "-explain",
    "-explain-types",
    "-indent",
    "-new-syntax",
    "-source:future",
    # "-language:strictEquality",
    # "-language:existentials",
    "-Ysafe-init",
    # "-Yexplicit-nulls",
    "-Xfatal-warnings",
]

alias(
    name = "3_0",
    actual = ":zinc_3_0_0",
    visibility = ["//visibility:public"],
)

runtime_classpath_3_0 = [
    "@scala_library_3_0_0//jar",
    "@scala_library_2_13_5//jar",
]

compiler_classpath_3_0 = [
    "@scala_compiler_3_0_0//jar",
    "@scala_interfaces_3_0_0//jar",
    "@scala_tasty_core_3_0_0//jar",
    "@scala_asm_9_1_0//jar",
] + runtime_classpath_3_0

configure_bootstrap_scala(
    name = "bootstrap_3_0_0",
    compiler_classpath = compiler_classpath_3_0,
    global_scalacopts = scala3_global_scalacopts,
    runtime_classpath = runtime_classpath_3_0,
    version = scala3_version,
    visibility = ["//visibility:public"],
)

configure_zinc_scala(
    name = "zinc_3_0_0",
    compiler_bridge = "@scala_sbt_bridge_3_0_0//jar",
    compiler_classpath = compiler_classpath_3_0,
    global_scalacopts = scala3_global_scalacopts,
    runtime_classpath = runtime_classpath_3_0,
    version = scala3_version,
    visibility = ["//visibility:public"],
)
