load(
    "@rules_scala3//rules:providers.bzl",
    _ScalaConfiguration = "ScalaConfiguration",
    _ScalaInfo = "ScalaInfo",
)
load(
    "//rules/common:private/utils.bzl",
    _collect = "collect",
)

#
# PHASE: javainfo
#
# Builds up the JavaInfo provider. And the ScalaInfo, while we're at it.
# And DefaultInfo.
#

def phase_javainfo(ctx, g):
    sruntime_deps = java_common.merge(_collect(JavaInfo, ctx.attr.runtime_deps))
    sexports = java_common.merge(_collect(JavaInfo, getattr(ctx.attr, "exports", [])))
    scala_configuration_runtime_deps = _collect(JavaInfo, g.init.scala_configuration.runtime_classpath)

    scala = getattr(ctx.attr, "scala", [])
    macro = getattr(ctx.attr, "macro", False) or \
            (_ScalaConfiguration in scala and scala[_ScalaConfiguration].version.startswith("3.")) or \
            (g.init.scala_configuration.version.startswith("3."))

    if len(ctx.attr.srcs) == 0 and len(ctx.attr.resources) == 0:
        java_info = java_common.merge([g.classpaths.sdeps, sexports])
    else:
        compile_jar = ctx.outputs.jar
        if not macro:
            compile_jar = java_common.run_ijar(
                ctx.actions,
                jar = ctx.outputs.jar,
                target_label = ctx.label,
                java_toolchain = ctx.attr._java_toolchain[java_common.JavaToolchainInfo],
            )

        source_jar = java_common.pack_sources(
            ctx.actions,
            output_source_jar = ctx.outputs.src_jar,
            sources = ctx.files.srcs,
            java_toolchain = ctx.attr._java_toolchain[java_common.JavaToolchainInfo],
        )

        java_info = JavaInfo(
            compile_jar = compile_jar,
            neverlink = getattr(ctx.attr, "neverlink", False),
            output_jar = ctx.outputs.jar,
            source_jar = source_jar,
            exports = [sexports],
            runtime_deps = [sruntime_deps] + scala_configuration_runtime_deps,
            deps = [g.classpaths.sdeps],
        )

    scala_info = _ScalaInfo(
        macro = macro,
        scala_configuration = g.init.scala_configuration,
    )

    output_group_info = OutputGroupInfo(
        **g.out.output_groups
    )

    g.out.providers.extend([
        output_group_info,
        java_info,
        scala_info,
    ])

    return struct(
        java_info = java_info,
        output_group_info = output_group_info,
        scala_info = scala_info,
    )
