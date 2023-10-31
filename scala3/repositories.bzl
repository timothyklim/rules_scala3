"""Repository rules for defining Scala dependencies and toolchains"""

# buildifier: disable=unnamed-macro
def scala_register_toolchains(scala_version = "latest"):
    native.register_toolchains("@rules_scala3//scala3:default_toolchain")
