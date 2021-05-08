load(
    "//rules/common:private/utils.bzl",
    _write_launcher = "write_launcher",
)
load("//rules:providers.bzl", _ScalaConfiguration = "ScalaConfiguration")

#
# PHASE: binary_launcher
#
# Writes a Scala binary launcher
#

def phase_binary_launcher(ctx, g):
    inputs = ctx.files.data

    if ctx.attr.main_class != "":
        main_class = ctx.attr.main_class
    else:
        mains_file = g.compile.mains_file
        inputs = inputs + [mains_file]
        main_class = "$(head -1 $JAVA_RUNFILES/{}/{})".format(ctx.workspace_name, mains_file.short_path)

    jvm_flags = []
    jvm_flags += ctx.attr.jvm_flags
    jvm_flags += ctx.attr.scala[_ScalaConfiguration].global_jvm_flags

    files = _write_launcher(
        ctx,
        "{}/".format(ctx.label.name),
        ctx.outputs.bin,
        g.javainfo.java_info.transitive_runtime_deps,
        jvm_flags = [ctx.expand_location(f, ctx.attr.data) for f in jvm_flags],
        main_class = main_class,
    )

    g.out.providers.append(DefaultInfo(
        executable = ctx.outputs.bin,
        files = depset([ctx.outputs.bin, ctx.outputs.jar]),
        runfiles = ctx.runfiles(
            files = inputs + files,
            transitive_files = depset(
                order = "default",
                transitive = [ctx.attr._target_jdk[java_common.JavaRuntimeInfo].files, g.javainfo.java_info.transitive_runtime_deps],
            ),
            collect_default = True,
        ),
    ))
