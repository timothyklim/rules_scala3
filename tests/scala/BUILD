load(
    "@rules_scala3//rules:scala.bzl",
    "configure_bootstrap_scala",
    "configure_zinc_scala",
    "scala_library",
)

alias(
    name = "2_13",
    actual = ":zinc_2_13",
    visibility = ["//visibility:public"],
)

# zinc 2.13.5

runtime_classpath_2_13_6 = [
    "@scala_library_2_13_6//jar",
]

compiler_classpath_2_13_6 = [
    "@scala_compiler_2_13_6//jar",
    "@scala_reflect_2_13_6//jar",
] + runtime_classpath_2_13_6

configure_bootstrap_scala(
    name = "bootstrap_2_13_6",
    compiler_classpath = compiler_classpath_2_13_6,
    runtime_classpath = runtime_classpath_2_13_6,
    version = "2.13.5",
    visibility = ["//visibility:public"],
)

scala_library(
    name = "compiler_bridge_2_13",
    srcs = [
        "@compiler_bridge_2_13//:src",
    ],
    resource_strip_prefix = "../compiler_bridge_2_13",
    resources = ["@compiler_bridge_2_13//:meta"],
    scala = ":bootstrap_2_13_6",
    visibility = ["//visibility:public"],
    deps = compiler_classpath_2_13_6 + [
        "@annex//:org_scala_sbt_compiler_interface",
        "@annex//:org_scala_sbt_util_interface",
    ],
)

configure_zinc_scala(
    name = "zinc_2_13",
    compiler_bridge = ":compiler_bridge_2_13",
    compiler_classpath = compiler_classpath_2_13_6,
    runtime_classpath = runtime_classpath_2_13_6,
    version = "2.13.5",
    visibility = ["//visibility:public"],
)

# Scala 3.0.0

alias(
    name = "3_0",
    actual = ":zinc_3_0_0",
    visibility = ["//visibility:public"],
)

runtime_classpath_3_0 = [
    "@scala_library_3_0_0//jar",
    "@scala_library_2_13_6//jar",
]

compiler_classpath_3_0 = [
    "@scala_compiler_3_0_0//jar",
    "@scala_interfaces_3_0_0//jar",
    "@scala_tasty_core_3_0_0//jar",
    "@scala_asm_9_1_0//jar",
] + runtime_classpath_3_0

# configure_bootstrap_scala(
#     name = "bootstrap_3_0",
#     compiler_classpath = compiler_classpath_3_0,
#     runtime_classpath = runtime_classpath_3_0,
#     version = "3.0.0",
#     visibility = ["//visibility:public"],
# )

# scala_library(
#     name = "compiler_bridge_3_0",
#     srcs = [
#         "@compiler_bridge_2_13//:src",
#     ],
#     resource_strip_prefix = "../compiler_bridge_2_13",
#     resources = ["@compiler_bridge_2_13//:meta"],
#     visibility = ["//visibility:public"],
#     deps = compiler_classpath_3_0 + [
#         "@annex//:org_scala_sbt_compiler_interface",
#         "@annex//:org_scala_sbt_util_interface",
#         "@scala_sbt_bridge_3_0_0",
#     ],
# )

configure_zinc_scala(
    name = "zinc_3_0_0",
    compiler_bridge = "@scala_sbt_bridge_3_0_0//jar",
    compiler_classpath = compiler_classpath_3_0,
    global_jvm_flags = ["-Xms8M"],
    log_level = "debug",
    runtime_classpath = runtime_classpath_3_0,
    version = "3.0.0",
    visibility = ["//visibility:public"],
)
