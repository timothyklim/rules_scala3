load("@rules_scala3//deps:scala_deps.bzl", "scala_deps")
load("@rules_scala3//rules:scala.bzl", "configure_zinc_scala")
load("@rules_scala3//scala3:toolchain.bzl", "scala_toolchain")
load("@rules_scala3//rules/scalafix:scalafix_runner.bzl", "scalafix_runner")
load('//scala3:repositories.bzl', _default_scalacopts = 'GLOBAL_SCALACOPTS')

filegroup(
    name = "dependencies",
    srcs = ["Dependencies.scala"],
    visibility = ["//visibility:public"],
)

scala_deps(
    name = "scala_deps",
    src = "//:dependencies",
    dependencies = "rules_scala3.Dependencies",
)

scalafix_runner(
    name = "run_scalafix",
    toolchain = "//:scalafix_toolchain",
    targets = ["//..."],
)

runtime_classpath_3 = [
    "@scala3_library//jar",
    "@scala_library_2_13//jar",
]

compiler_classpath_3 = runtime_classpath_3 + [
    "@scala3_compiler//jar",
    "@scala3_interfaces//jar",
    "@scala_tasty_core_3//jar",
    "@scala_asm//jar",
]

scala_version = "3.6.2-RC1"

scalac_scalafix_opts = [
    "-Wunused:all",
    "-Ywarn-unused",
    "-Xsemanticdb"
]

configure_zinc_scala(
    name = "zinc_3",
    compiler_bridge = "@scala3_sbt_bridge//jar",
    compiler_classpath = compiler_classpath_3,
    runtime_classpath = runtime_classpath_3,
    version = scala_version,
    visibility = ["//visibility:public"],
)

scala_toolchain(
    name = "scalafix_toolchain_impl",
    compiler_bridge = "@scala3_sbt_bridge//jar",
    compiler_classpath = compiler_classpath_3,
    enable_semanticdb = True,
    global_scalacopts = _default_scalacopts + scalac_scalafix_opts,
    runtime_classpath = runtime_classpath_3,
    scala_version = scala_version,
    semanticdb_bundle_in_jar = True,
)

toolchain(
    name = "scalafix_toolchain",
    toolchain = ":scalafix_toolchain_impl",
    toolchain_type = "//scala3:toolchain_type",
    visibility = ["//visibility:public"],
)

