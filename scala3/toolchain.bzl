"""This module implements the `scala_toolchain`."""

attrs = {
    "enable_semanticdb": attr.bool(
        default = False,
        doc = "Enable SemanticDB",
    ),
}

def _scala_toolchain_impl(ctx):
    toolchain_info = platform_common.ToolchainInfo(
        enable_semanticdb = ctx.attr.enable_semanticdb,
    )
    return [toolchain_info]

scala_toolchain = rule(
    implementation = _scala_toolchain_impl,
    fragments = ["java"],
    attrs = attrs,
    doc = """Declares a Scala toolchain.

    Example:

    ```python
    # Some BUILD file in your project where you define toolchain
    load('@rules_scala3//scala3:toolchain.bzl', 'rust_toolchain')

    scala_toolchain(
        name = "custom_toolchain_impl",
        enable_semanticdb = True,
    )

    toolchain(
        name = "custom_toolchain",
        toolchain = ":custom_toolchain_impl",
        toolchain_type = "@rules_scala3//scala3:toolchain_type",
    )
    ```

    Then, either add the label of the toolchain rule to `register_toolchains` in the WORKSPACE, or pass \
    it to the `"--extra_toolchains"` flag for Bazel, and it will be used.

    For usage see <https://docs.bazel.build/versions/main/toolchains.html#toolchain-definitions>.
    """,
)
