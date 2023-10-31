load("//scala3:toolchain.bzl", "scala_toolchain")

toolchain_type(
    name = "toolchain_type",
    visibility = ["//visibility:public"],
)

scala_toolchain(name = "default_toolchain_impl")

toolchain(
    name = "default_toolchain",
    toolchain = ":default_toolchain_impl",
    toolchain_type = ":toolchain_type",
)
