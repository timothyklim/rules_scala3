load(
    "@rules_scala3//rules:providers.bzl",
    "declare_scala_configuration",
    "declare_zinc_configuration",
    "join_configurations",
)
load(
    "@rules_scala3//rules:scala.bzl",
    "configure_bootstrap_scala",
)
load(
    ":build.bzl",
    "consume_scala_and_zinc_configuration",
    "consume_scala_configuration",
    "consume_zinc_configuration",
)

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

scala3 = "3.6.1"

declare_scala_configuration(
    name = "provided_scala_configuration",
    compiler_classpath = compiler_classpath_3,
    runtime_classpath = runtime_classpath_3,
    version = scala3,
)

configure_bootstrap_scala(
    name = "bootstrap",
    compiler_classpath = compiler_classpath_3,
    runtime_classpath = runtime_classpath_3,
    version = scala3,
    visibility = ["//visibility:public"],
)

declare_zinc_configuration(
    name = "provided_zinc_configuration",
    compiler_bridge = ":compiler_bridge",
)

join_configurations(
    name = "provided_scala_and_zinc_configuration",
    configurations = [
        ":provided_scala_configuration",
        ":provided_zinc_configuration",
    ],
)

consume_scala_configuration(
    name = "consume_scala_configuration",
    configuration = ":provided_scala_configuration",
)

consume_scala_configuration(
    name = "consume_scala_as_zinc_configuration",
    configuration = ":provided_zinc_configuration",
)

consume_zinc_configuration(
    name = "consume_zinc_configuration",
    configuration = ":provided_zinc_configuration",
)

consume_zinc_configuration(
    name = "consume_zinc_as_scala_configuration",
    configuration = ":provided_scala_configuration",
)

consume_scala_and_zinc_configuration(
    name = "consume_scala_and_zinc_configuration",
    configuration = ":provided_scala_and_zinc_configuration",
)

consume_scala_configuration(
    name = "consume_scala_and_zinc_as_scala_configuration",
    configuration = ":provided_scala_and_zinc_configuration",
)

consume_zinc_configuration(
    name = "consume_scala_and_zinc_as_zinc_configuration",
    configuration = ":provided_scala_and_zinc_configuration",
)
