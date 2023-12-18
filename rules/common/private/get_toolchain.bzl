"A module defining `get_toolchain`"

load(
    "@rules_scala3//rules:providers.bzl",
    _CodeCoverageConfiguration = "CodeCoverageConfiguration",
    _DepsConfiguration = "DepsConfiguration",
    _ScalaConfiguration = "ScalaConfiguration",
    _ScalaRulePhase = "ScalaRulePhase",
    _ZincConfiguration = "ZincConfiguration",
)

def _gen_toolchain(scala, toolchain):
    toolchain_info = platform_common.ToolchainInfo(
        scala_version = scala[_ScalaConfiguration].version,
        enable_semanticdb = toolchain.enable_semanticdb,
        semanticdb_bundle_in_jar = toolchain.semanticdb_bundle_in_jar,
        is_zinc = True if _ZincConfiguration in scala else False,
        zinc_log_level = scala[_ZincConfiguration].log_level if _ZincConfiguration in scala else None,
        compiler_bridge = scala[_ZincConfiguration].compiler_bridge if _ZincConfiguration in scala else None,
        compiler_classpath = scala[_ScalaConfiguration].compiler_classpath,
        runtime_classpath = scala[_ScalaConfiguration].runtime_classpath,
        global_plugins = scala[_ScalaConfiguration].global_plugins,
        global_scalacopts = scala[_ScalaConfiguration].global_scalacopts,
        global_jvm_flags = scala[_ScalaConfiguration].global_jvm_flags,
        phases = scala[_ScalaRulePhase].phases,
        compile_worker = scala[_ZincConfiguration].compile_worker if _ZincConfiguration in scala else None,
        coverage_instrumentation_worker = scala[_CodeCoverageConfiguration].instrumentation_worker if _CodeCoverageConfiguration in scala else None,
        deps_worker = scala[_DepsConfiguration].worker if _DepsConfiguration in scala else None,
        deps_direct = scala[_DepsConfiguration].direct if _DepsConfiguration in scala else None,
        deps_used = scala[_DepsConfiguration].used if _DepsConfiguration in scala else None,
    )
    return toolchain_info

def get_toolchain(ctx):
    """Configures the toolchain according to the `scala` attrubutet.

    If `scala` attribute was specified in the rule, toolchain will be generated
    on the fly based on the value of the attribute.

    Args:
        ctx: The rule's context.

    Returns:
        ToolchainInfo: Standard Bazel toolchain provider.
    """

    if getattr(ctx.attr, "_worker_rule", False):
        stub_toolchain = platform_common.ToolchainInfo(
            enable_semanticdb = False,
            semanticdb_bundle_in_jar = False,
        )
        return _gen_toolchain(ctx.attr._scala, stub_toolchain)

    toolchain = ctx.toolchains["@rules_scala3//scala3:toolchain_type"]

    if getattr(ctx.attr, "scala", False):
        return _gen_toolchain(ctx.attr.scala, toolchain)

    return toolchain
