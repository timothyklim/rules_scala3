load(
    "@rules_scala_annex//rules:scala.bzl",
    "configure_bootstrap_scala",
    "configure_zinc_scala",
    "scala_library",
)

alias(
    name = "2_13",
    actual = ":zinc_2_13",
    visibility = ["//visibility:public"],
)

# zinc 2.13.4

compiler_classpath_2_13_4 = [
    "@scala_compiler_2_13_4//jar",
    "@scala_library_2_13_4//jar",
    "@scala_reflect_2_13_4//jar",
]

runtime_classpath_2_13_4 = [
    "@scala_library_2_13_4//jar",
]

configure_bootstrap_scala(
    name = "bootstrap_2_13_4",
    compiler_classpath = compiler_classpath_2_13_4,
    runtime_classpath = runtime_classpath_2_13_4,
    version = "2.13.4",
    visibility = ["//visibility:public"],
)

scala_library(
    name = "compiler_bridge_2_13_4",
    srcs = [
        "@compiler_bridge_2_13//:src",
    ],
    resource_strip_prefix = "../compiler_bridge_2_13",
    resources = ["@compiler_bridge_2_13//:meta"],
    scala = ":bootstrap_2_13_4",
    visibility = ["//visibility:public"],
    deps = compiler_classpath_2_13_4 + [
        "@annex//:org_scala_sbt_compiler_interface",
        "@annex//:org_scala_sbt_util_interface",
    ],
)

configure_zinc_scala(
    name = "zinc_2_13",
    compiler_bridge = ":compiler_bridge_2_13_4",
    compiler_classpath = compiler_classpath_2_13_4,
    runtime_classpath = runtime_classpath_2_13_4,
    version = "2.13.4",
    visibility = ["//visibility:public"],
)

# For global scalacoptions test
configure_zinc_scala(
    name = "zinc_2_13_4_fatal_deprecation_opt",
    compiler_bridge = ":compiler_bridge_2_13_4",
    compiler_classpath = compiler_classpath_2_13_4,
    global_scalacopts = [
        "-deprecation",
        "-Xfatal-warnings",
    ],
    runtime_classpath = runtime_classpath_2_13_4,
    version = "2.13.4",
    visibility = ["//scalacopts/rule:__subpackages__"],
)

# for log_level test
configure_zinc_scala(
    name = "zinc_2_13_4_log_level_debug",
    compiler_bridge = ":compiler_bridge_2_13_4",
    compiler_classpath = compiler_classpath_2_13_4,
    log_level = "debug",
    runtime_classpath = runtime_classpath_2_13_4,
    version = "2.13.4",
    visibility = ["//visibility:public"],
)

# Scala 3.0.0-M3

alias(
    name = "3_0",
    actual = ":zinc_3_0",
    visibility = ["//visibility:public"],
)

runtime_classpath_3_0 = [
    "@scala_library_3_0_0_M3//jar",
    "@scala_library_2_13_4//jar",
]

compiler_classpath_3_0 = runtime_classpath_3_0 + [
    "@scala_compiler_3_0_0_M3//jar",
    "@scala_interfaces_3_0_0_M3//jar",
    "@scala_tasty_core_3_0_0_M3//jar",
    "@scala_asm_7_3_1//jar",
]

configure_zinc_scala(
    name = "zinc_3_0",
    compiler_bridge = "@scala_sbt_bridge_3_0_0_M3//jar",
    compiler_classpath = compiler_classpath_3_0,
    log_level = "debug",
    runtime_classpath = runtime_classpath_3_0,
    version = "3.0.0-M3",
    visibility = ["//visibility:public"],
)

