load("@rules_scala_annex//rules:scala.bzl", "configure_zinc_scala", "scala_library")

scala_library(
    name = "kind-projector",
    srcs = ["KindProjector.scala"],
    plugins = [
        "@kind_projector_2_13//jar",
    ],
    tags = ["manual"],
)

configure_zinc_scala(
    name = "scala_2_13_5_with_kind_projector",
    compiler_bridge = "//scala:compiler_bridge_2_13_5",
    compiler_classpath = [
        "@scala_compiler_2_13_5//jar",
        "@scala_reflect_2_13_5//jar",
        "@scala_library_2_13_5//jar",
    ],
    global_plugins = [
        "@kind_projector_2_13//jar",
    ],
    runtime_classpath = [
        "@scala_library_2_13_5//jar",
    ],
    version = "2.13.5",
)

scala_library(
    name = "kind-projector-via-global-plugins",
    srcs = ["KindProjector.scala"],
    scala = ":scala_2_13_5_with_kind_projector",
    tags = ["manual"],
)
