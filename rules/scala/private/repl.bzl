load("@bazel_skylib//lib:dicts.bzl", _dicts = "dicts")
load(
    "@rules_scala3//rules:providers.bzl",
    _ScalaConfiguration = "ScalaConfiguration",
    _ZincConfiguration = "ZincConfiguration",
)
load("//rules/common:private/utils.bzl", "write_launcher", _collect = "collect")

def scala_repl_implementation(ctx):
    scala_configuration = ctx.attr.scala[_ScalaConfiguration]
    zinc_configuration = ctx.attr.scala[_ZincConfiguration]

    scompiler_classpath = java_common.merge(
        _collect(JavaInfo, scala_configuration.compiler_classpath),
    )

    classpath = depset(transitive = [dep[JavaInfo].transitive_runtime_jars for dep in ctx.attr.deps])
    runner_classpath = ctx.attr._runner[JavaInfo].transitive_runtime_jars

    args = ctx.actions.args()
    args.add("--compiler_bridge", zinc_configuration.compiler_bridge.short_path)
    args.add_all(scompiler_classpath.transitive_runtime_jars, map_each = _short_path, format_each = "--compiler_cp=%s")
    args.add_all(classpath, map_each = _short_path, format_each = "--cp=%s")
    args.add_all(scala_configuration.global_scalacopts, format_each = "--compiler_option=%s")
    args.add_all(ctx.attr.scalacopts, format_each = "--compiler_option=%s")
    if ctx.attr.initial_commands != None:
        args.add(ctx.attr.initial_commands, format = "--initial_commands=%s")
    if ctx.attr.cleanup_commands != None:
        args.add(ctx.attr.cleanup_commands, format = "--cleanup_commands=%s")
    args.set_param_file_format("multiline")
    args_file = ctx.actions.declare_file("{}/repl.params".format(ctx.label.name))
    ctx.actions.write(args_file, args)

    launcher_files = write_launcher(
        ctx,
        "{}/".format(ctx.label.name),
        ctx.outputs.bin,
        runner_classpath,
        "rules_scala.workers.zinc.repl.ReplRunner",
        [ctx.expand_location(f, ctx.attr.data) for f in ctx.attr.jvm_flags] + [
            "-Dbazel.runPath=$RUNPATH",
            "-DscalaAnnex.test.args=${{RUNPATH}}{}".format(args_file.short_path),
        ],
    )

    files = depset(
        [args_file, zinc_configuration.compiler_bridge] + launcher_files,
        transitive = [classpath, runner_classpath, scompiler_classpath.transitive_runtime_jars],
    )
    return [
        DefaultInfo(
            executable = ctx.outputs.bin,
            files = depset([ctx.outputs.bin], transitive = [files]),
            runfiles = ctx.runfiles(
                collect_default = True,
                collect_data = True,
                files = ctx.attr._target_jdk[java_common.JavaRuntimeInfo].files.to_list(),
                transitive_files = files,
            ),
        ),
    ]

def _short_path(file):
    return file.short_path
