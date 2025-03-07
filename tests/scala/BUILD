load("@rules_scala3//rules:scala.bzl", "configure_zinc_scala")

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

scala3 = "3.6.4"

configure_zinc_scala(
    name = "zinc_3_fatal_deprecation_opt",
    compiler_bridge = "@scala3_sbt_bridge//jar",
    compiler_classpath = compiler_classpath_3,
    global_scalacopts = [
        "-deprecation",
        "-Xfatal-warnings",
    ],
    runtime_classpath = runtime_classpath_3,
    version = scala3,
    visibility = ["//scalacopts/rule:__subpackages__"],
)
