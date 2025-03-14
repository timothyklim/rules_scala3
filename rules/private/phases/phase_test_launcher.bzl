load(
    "@rules_scala3//rules/private:coverage_replacements_provider.bzl",
    _coverage_replacements_provider = "coverage_replacements_provider",
)
load(
    "//rules/common:private/utils.bzl",
    _action_singlejar = "action_singlejar",
    _collect = "collect",
    _write_launcher = "write_launcher",
)

#
# PHASE: test_launcher
#
# Writes a Scala test launcher
#

def phase_test_launcher(ctx, g):
    files = ctx.attr._target_jdk[java_common.JavaRuntimeInfo].files.to_list() + ctx.files._agent + [g.compile.zinc_info.analysis_store]

    coverage_replacements = {}
    coverage_runner_jars = depset(direct = [])
    if ctx.configuration.coverage_enabled:
        coverage_replacements = _coverage_replacements_provider.from_ctx(
            ctx,
            base = g.coverage.replacements,
        ).replacements
        coverage_runner_jars = depset(direct = [ctx.files._jacocorunner + ctx.files._lcov_merger])

    test_jars = depset(direct = [
        coverage_replacements[jar] if jar in coverage_replacements else jar
        for jar in g.javainfo.java_info.transitive_runtime_jars.to_list()
    ])
    runner_jars = depset(transitive = [ctx.attr.runner[JavaInfo].transitive_runtime_jars, coverage_runner_jars])
    all_jars = [test_jars, runner_jars]

    jvm_flags = ctx.attr.jvm_flags + [
        "--enable-preview",
        "-javaagent:" + ctx.files._agent[0].short_path,
    ]

    args = ctx.actions.args()
    args.add("--parallel", ctx.attr.parallel)
    if ctx.attr.parallel_n:
        args.add(ctx.attr.parallel_n, format = "--parallel-n=%s")
    args.add("--analysis_store", g.compile.zinc_info.analysis_store.short_path)
    args.add_all(ctx.attr.frameworks, format_each = "--framework=%s")
    if ctx.attr.isolation == "classloader":
        shared_deps = java_common.merge(_collect(JavaInfo, ctx.attr.shared_deps))
        args.add("--isolation", "classloader")
        args.add_all("--shared_classpath", shared_deps.transitive_runtime_jars, map_each = _test_launcher_short_path)
    elif ctx.attr.isolation == "process":
        subprocess_executable = ctx.actions.declare_file("{}/subprocess".format(ctx.label.name))
        subprocess_runner_jars = ctx.attr.subprocess_runner[JavaInfo].transitive_runtime_jars
        all_jars.append(subprocess_runner_jars)
        files += _write_launcher(
            ctx,
            "{}/subprocess-".format(ctx.label.name),
            subprocess_executable,
            subprocess_runner_jars,
            "rules_scala3.common.sbt_testing.SubprocessTestRunner",
            [ctx.expand_location(f, ctx.attr.data) for f in jvm_flags],
        )
        files.append(subprocess_executable)
        args.add("--isolation", "process")
        args.add("--subprocess_exec", subprocess_executable.short_path)
    args.add_all(test_jars, map_each = _test_launcher_short_path)
    args.set_param_file_format("multiline")
    args_file = ctx.actions.declare_file("{}/test.params".format(ctx.label.name))
    ctx.actions.write(args_file, args)
    files.append(args_file)

    jacoco_classpath = None
    if ctx.configuration.coverage_enabled:
        jacoco_classpath = test_jars

    files += _write_launcher(
        ctx = ctx,
        prefix = "{}/".format(ctx.label.name),
        output = ctx.outputs.bin,
        runtime_classpath = runner_jars,  # + ctx.files._jacocorunner,
        main_class = "rules_scala3.workers.zinc.test.TestRunner",
        jvm_flags = [ctx.expand_location(f, ctx.attr.data) for f in jvm_flags] + [
            "-Dbazel.runPath=$RUNPATH",
            "-DscalaAnnex.test.args=${{RUNPATH}}{}".format(args_file.short_path),
        ],
        jacoco_classpath = jacoco_classpath,
    )

    g.out.providers.append(DefaultInfo(
        executable = ctx.outputs.bin,
        files = depset([ctx.outputs.jar]),
        runfiles = ctx.runfiles(
            collect_data = True,
            collect_default = True,
            files = files,
            transitive_files = depset([], transitive = all_jars),
        ),
    ))

def _test_launcher_short_path(file):
    return file.short_path
