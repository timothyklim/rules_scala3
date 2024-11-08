load("@rules_scala3//rules:scala.bzl", "configure_zinc_scala", "scala_library")

scala_library(
    name = "kind-projector",
    srcs = ["KindProjector.scala"],
    plugins = [
        "//3rdparty/jvm/org/typelevel:kind_projector",
    ],
    tags = ["manual"],
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

configure_zinc_scala(
    name = "scala_2_13_11_with_kind_projector",
    compiler_bridge = "@scala3_sbt_bridge//jar",
    compiler_classpath = compiler_classpath_3,
    global_plugins = [
        "//3rdparty/jvm/org/typelevel:kind_projector",
    ],
    runtime_classpath = runtime_classpath_3,
    version = scala3,
    visibility = ["//visibility:public"],
)

scala_library(
    name = "kind-projector-via-global-plugins",
    srcs = ["KindProjector.scala"],
    scala = ":scala_2_13_11_with_kind_projector",
    tags = ["manual"],
)
