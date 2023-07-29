load(
    "@bazel_tools//tools/jdk:toolchain_utils.bzl",
    "find_java_runtime_toolchain",
    "find_java_toolchain",
)

scala_import_private_attributes = {
    "_java_toolchain": attr.label(
        default = Label("@bazel_tools//tools/jdk:current_java_toolchain"),
    ),
    "_host_javabase": attr.label(
        default = Label("@bazel_tools//tools/jdk:current_java_runtime"),
        cfg = "exec",
    ),
}

def scala_import_implementation(ctx):
    default_info = DefaultInfo(
        files = depset(ctx.files.jars + ctx.files.srcjar + ctx.files.exports),
    )

    if ctx.files.jars:
        _jar = []
        _src_jar = []
        for jar in ctx.files.jars:
            if jar.basename.endswith("sources.jar") or jar.basename.endswith("src.jar"):
                _src_jar.append(jar)
            else:
                _jar.append(jar)
        _src_jar += ctx.files.srcjar

        # TODO: maybe eventually we should use this. Right now it produces
        # a warning:
        #   WARNING: Duplicate name in Manifest: <MANIFEST.MF entry>.
        #   Ensure that the manifest does not have duplicate entries, and
        #   that blank lines separate individual sections in both your
        #   manifest and in the META-INF/MANIFEST.MF entry in the jar file.
        #
        # It does this for all kinds of MANIFEST.MF entries. For example:
        #   * Implementation-Version
        #   * Implementation-Title
        #   * Implementation-URL
        # and a bunch of others
        #
        # compile_jar = java_common.stamp_jar(
        #     ctx.actions,
        #     jar = output_jar,
        #     target_label = ctx.label,
        #     java_toolchain = ctx.attr._java_toolchain,
        # )

        source_jar = java_common.pack_sources(
            ctx.actions,
            output_source_jar = ctx.actions.declare_file("%s-src.jar" % ctx.attr.name),
            source_jars = _src_jar,
            java_toolchain = find_java_toolchain(ctx, ctx.attr._java_toolchain),
        )

        output_jar = _jar[0]
        java_info = JavaInfo(
            output_jar = output_jar,
            compile_jar = output_jar,
            source_jar = source_jar,
            deps = [dep[JavaInfo] for dep in ctx.attr.deps],
            neverlink = ctx.attr.neverlink,
            runtime_deps = [runtime_dep[JavaInfo] for runtime_dep in ctx.attr.runtime_deps],
            exports = [dep[JavaInfo] for dep in ctx.attr.exports],
        )
    elif ctx.files.exports:
        _jar = []
        for jar in ctx.files.exports:
            if not jar.basename.endswith("sources.jar") and not jar.basename.endswith("src.jar"):
                _jar.append(jar)
        output_jar = _jar[0]

        java_info = JavaInfo(
            output_jar = output_jar,
            compile_jar = output_jar,
            source_jar = None,
            deps = [dep[JavaInfo] for dep in ctx.attr.deps],
            neverlink = ctx.attr.neverlink,
            runtime_deps = [runtime_dep[JavaInfo] for runtime_dep in ctx.attr.runtime_deps],
            exports = [],
        )
    else:
        java_info = java_common.merge([dep[JavaInfo] for dep in ctx.attr.deps])

    return struct(
        java = java_info,
        providers = [
            java_info,
            default_info,
        ],
    )
