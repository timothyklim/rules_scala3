load(
    "@rules_scala3//rules:providers.bzl",
    _LabeledJars = "LabeledJars",
)
load(
    "@rules_scala3//rules/common:private/utils.bzl",
    _resolve_execution_reqs = "resolve_execution_reqs",
)
load("//rules/common:private/get_toolchain.bzl", "get_toolchain")

#
# PHASE: depscheck
# Dependencies are checked to see if they are used/unused.
# Success files are outputted if dependency checking was "successful"
# according to the configuration/options.
#

def _full_label(label):
  return "@@" + label.workspace_name + "//" + label.package + ":" + label.name

def phase_zinc_depscheck(ctx, g):
    toolchain = get_toolchain(ctx)

    if not toolchain.is_zinc:
        return

    deps_checks = {}
    labeled_jars = depset(transitive = [dep[_LabeledJars].values for dep in ctx.attr.deps])
    worker_inputs, _, worker_input_manifests = ctx.resolve_command(tools = [toolchain.deps_worker])
    for name in ("direct", "used"):
        deps_check = ctx.actions.declare_file("{}/depscheck_{}.success".format(ctx.label.name, name))
        deps_args = ctx.actions.args()
        deps_args.add(name, format = "--check_%s=true")
        deps_args.add_all([_full_label(dep.label) for dep in ctx.attr.deps], format_each = "--direct=_%s")
        deps_args.add_all(labeled_jars, map_each = _depscheck_labeled_group)
        deps_args.add("--label", ctx.label, format = "_%s")
        deps_args.add_all([_full_label(dep.label) for dep in ctx.attr.deps_used_whitelist], format_each = "--used_whitelist=_%s")
        deps_args.add_all([_full_label(dep.label) for dep in ctx.attr.deps_unused_whitelist], format_each = "--unused_whitelist=_%s")
        deps_args.add(g.compile.used)
        deps_args.add(deps_check)
        deps_args.set_param_file_format("multiline")
        deps_args.use_param_file("@%s", use_always = True)
        ctx.actions.run(
            mnemonic = "ScalaCheckDeps",
            inputs = [g.compile.used] + worker_inputs,
            outputs = [deps_check],
            executable = toolchain.deps_worker.files_to_run.executable,
            input_manifests = worker_input_manifests,
            execution_requirements = _resolve_execution_reqs(ctx, {"supports-workers": "1"}),
            arguments = [deps_args],
            use_default_shell_env = True,
        )
        deps_checks[name] = deps_check

    outputs = []
    if toolchain.deps_direct == "error":
        outputs.append(deps_checks["direct"])
    if toolchain.deps_used == "error":
        outputs.append(deps_checks["used"])

    g.out.output_groups["depscheck"] = depset(outputs)

    return struct(
        checks = deps_checks,
        outputs = outputs,
    )

def _depscheck_labeled_group(labeled_jars):
    return ["--group", ",".join(["_{}".format(labeled_jars.label)] + [jar.path for jar in labeled_jars.jars.to_list()])]
