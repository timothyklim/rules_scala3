"""This module implements the `scala_toolchain`."""

load(
    "//rules:private_proxy.bzl",
    _phase_bootstrap_compile = "phase_bootstrap_compile",
    _phase_zinc_compile = "phase_zinc_compile",
    _phase_zinc_depscheck = "phase_zinc_depscheck",
)
load(
    "//scala3/private:toolchain_constants.bzl",
    _toolchain_attrs = "SCALA_TOOLCHAIN_ATTRS",
)

def _scala_toolchain_impl(ctx):
    if ctx.attr.is_zinc:
        phases = [
            ("=", "compile", "compile", _phase_zinc_compile),
            ("+", "compile", "depscheck", _phase_zinc_depscheck),
        ]
    else:
        phases = [
            ("=", "compile", "compile", _phase_bootstrap_compile),
        ]

    if not ctx.attr.deps_direct in ["off", "warn", "error"]:
        fail("Argument `deps_direct` of `scala_toolchains` must be one of off, warn, error.")

    if not ctx.attr.deps_used in ["off", "warn", "error"]:
        fail("Argument `deps_used` of `scala_toolchains` must be one of off, warn, error.")

    toolchain_info = platform_common.ToolchainInfo(
        enable_semanticdb = ctx.attr.enable_semanticdb,
        semanticdb_bundle_in_jar = ctx.attr.semanticdb_bundle_in_jar,
        is_zinc = ctx.attr.is_zinc,
        zinc_log_level = ctx.attr.zinc_log_level,
        compiler_bridge = ctx.file.compiler_bridge,
        compiler_classpath = ctx.attr.compiler_classpath,
        runtime_classpath = ctx.attr.runtime_classpath,
        global_plugins = ctx.attr.global_plugins,
        global_scalacopts = ctx.attr.global_scalacopts,
        global_jvm_flags = ctx.attr.global_jvm_flags,
        phases = phases,
        compile_worker = ctx.attr._compile_worker,
        coverage_instrumentation_worker = ctx.attr._code_coverage_instrumentation_worker,
        deps_worker = ctx.attr._deps_worker,
        deps_direct = ctx.attr.deps_direct,
        deps_used = ctx.attr.deps_used,
    )
    return [toolchain_info]

scala_toolchain = rule(
    implementation = _scala_toolchain_impl,
    attrs = _toolchain_attrs,
    doc = """Declares a Scala toolchain.

    Example:

    ```python
    # Some BUILD file in your project where you define toolchain
    load('@rules_scala3//scala3:toolchain.bzl', 'rust_toolchain')
    load('//scala3:repositories.bzl', _default_scalacopts = 'GLOBAL_SCALACOPTS')

    scala_toolchain(
        name = "custom_toolchain_impl",
        global_scalacopts = _default_scalacopts + [
            "-some-option",
        ],
        compiler_bridge = "//my_custom_bridge:jar",
        compiler_classpath = [
            "//my_custom_deps:scala_compiler_3_jar",
            "//my_custom_deps:scala_library_3_jar",
            "//my_custom_deps:scala_library_2_jar",
        ],
        runtime_classpath = [
            "//my_custom_deps:scala_library_3_jar",
            "//my_custom_deps:scala_library_2_jar",
        ],
    )

    toolchain(
        name = "custom_toolchain",
        toolchain = ":custom_toolchain_impl",
        toolchain_type = "@rules_scala3//scala3:toolchain_type",
    )
    ```

    Then, either add the label of the toolchain rule to `register_toolchains` in the
    WORKSPACE, or pass it to the `"--extra_toolchains"` flag for Bazel, and it will
    be used.

    For usage see
    <https://docs.bazel.build/versions/main/toolchains.html#toolchain-definitions>.
    """,
)
