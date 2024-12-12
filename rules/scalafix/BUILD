load("@rules_scala3//rules:scala.bzl", "scala_binary")
load("@rules_scala3//scala3:toolchain.bzl", "scala_toolchain")
load('@rules_scala3//scala3:repositories.bzl', _default_scalacopts = 'GLOBAL_SCALACOPTS')

scala_version = "3.6.2-RC1"

scalac_scalafix_opts = [
    "-Wunused:all",
    "-Ywarn-unused",
    "-Xsemanticdb"
]

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

scala_binary(
    name = "bin",
    srcs = glob(include = ["*.scala"]),
    main_class = "rules_scala3.rules.scalafix.Main",
    visibility = ["//visibility:public"],
    deps = ["//3rdparty/jvm/ch/epfl/scala:scalafix_cli"],
)

toolchain_type(
    name = "scalafix_toolchain_type",
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
    toolchain_type = "@rules_scala3//rules/scalafix:scalafix_toolchain_type",
    visibility = ["//visibility:public"],
)

filegroup(
    name = "bzl",
    srcs = glob(["**/*.bzl"]),
    visibility = ["//rules:__pkg__"],
)
