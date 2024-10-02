load(
    "@rules_scala3//rules:scala.bzl",
    "configure_bootstrap_scala",
    "configure_zinc_scala",
    "scala_library",
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

scala2 = "2.13.12"

compiler_classpath_2_13 = [
    "@scala_compiler_2_13//jar",
    "@scala_library_2_13//jar",
    "@scala_reflect_2_13//jar",
]

runtime_classpath_2_13 = [
    "@scala_library_2_13//jar",
]

configure_bootstrap_scala(
    name = "bootstrap_2_13",
    compiler_classpath = compiler_classpath_2_13,
    runtime_classpath = runtime_classpath_2_13,
    version = scala2,
    visibility = ["//visibility:public"],
)

scala_library(
    name = "compiler_bridge_2_13",
    srcs = ["@compiler_bridge_2_13//:src"],
    resource_strip_prefix = "../compiler_bridge_2_13",
    resources = ["@compiler_bridge_2_13//:meta"],
    scala = ":bootstrap_2_13",
    visibility = ["//visibility:public"],
    deps = compiler_classpath_2_13 + [
        "@annex//:org_scala_sbt_compiler_interface",
        "@annex//:org_scala_sbt_util_interface",
    ],
)

configure_zinc_scala(
    name = "zinc_2_13",
    compiler_bridge = ":compiler_bridge_2_13",
    compiler_classpath = compiler_classpath_2_13,
    runtime_classpath = runtime_classpath_2_13,
    version = scala2,
    visibility = ["//visibility:public"],
)

alias(
    name = "2_13",
    actual = ":zinc_2_13",
    visibility = ["//visibility:public"],
)

scala3 = "3.5.1-RC1"

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
    # "-Xfatal-warnings",
    "-Wconf:any:warning",
    "-Wunused:imports",
    "-Wunused:locals",
    "-Wunused:privates",
    "-Wunused:params",
    "-Wunused:unsafe-warn-patvars",
    "-Wunused:linted",
    "-Wunused:implicits",
]

runtime_classpath_3 = [
    "@scala3_library//jar",
    "@scala_library_2_13//jar",
]

compiler_classpath_3 = [
    "@scala3_compiler//jar",
    "@scala3_interfaces//jar",
    "@scala_tasty_core_3//jar",
    "@scala_asm//jar",
    "@org_scala_sbt_compiler_interface//jar",
] + runtime_classpath_3

configure_bootstrap_scala(
    name = "bootstrap_3",
    compiler_classpath = compiler_classpath_3,
    global_scalacopts = scala3_global_scalacopts,
    runtime_classpath = runtime_classpath_3,
    version = scala3,
    visibility = ["//visibility:public"],
)

configure_zinc_scala(
    name = "zinc_3",
    compiler_bridge = "@scala3_sbt_bridge//jar",
    compiler_classpath = compiler_classpath_3,
    global_scalacopts = scala3_global_scalacopts,
    runtime_classpath = runtime_classpath_3,
    version = scala3,
    visibility = ["//visibility:public"],
)

configure_zinc_scala(
    name = "zinc_3_migration",
    compiler_bridge = "@scala3_sbt_bridge//jar",
    compiler_classpath = compiler_classpath_3,
    global_scalacopts = ["-source:3.0-migration"],
    runtime_classpath = runtime_classpath_3,
    version = scala3,
    visibility = ["//visibility:public"],
)

alias(
    name = "3_4",
    actual = ":zinc_3",
    visibility = ["//visibility:public"],
)
