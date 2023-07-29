load("@rules_scala3//rules:scala.bzl", "scala_library")
load(
    "@rules_scala3//rules:providers.bzl",
    _ScalaConfiguration = "ScalaConfiguration",
    _ScalaInfo = "ScalaInfo",
)
load(
    "@rules_scala3//rules/common:private/utils.bzl",
    _resolve_execution_reqs = "resolve_execution_reqs",
)

def scalajs_library(name, srcs, deps = [], visibility = None, scalacopts = [], scala = None, deps_used_whitelist = []):
    """Make scalajs library for provided sources"""
    scala_library(
        name = name,
        srcs = srcs,
        visibility = visibility,
        deps_used_whitelist = [
            "@scalajs_library_2_13//jar",
        ] + deps_used_whitelist,
        deps = [
            "@scalajs_library_2_13//jar",
        ] + deps,
        scalacopts = ["-scalajs"] + scalacopts,
        scala = scala,
    )

def _scalajs_link_impl(ctx):
    out = ctx.actions.declare_file("{}.js".format(ctx.label.name))
    inputs = []
    for dep in ctx.attr.deps:
        if _ScalaInfo in dep:
            inputs += [dep for dep in dep[JavaInfo].transitive_runtime_jars.to_list()]

    args = ctx.actions.args()
    args.add("--main-class", ctx.attr.main_class)
    args.add("--main-method", ctx.attr.main_method)
    args.add("--with-args", "true" if ctx.attr.main_method_with_args else "false")
    args.add("--full-opt", "true" if ctx.attr.full_opt else "false")
    args.add("--module", ctx.attr.module_kind)
    args.add("--dest", out.path)
    args.add_all(inputs)

    outputs = [out]
    ctx.actions.run(
        mnemonic = "ScalaJsLinker",
        inputs = inputs,
        outputs = outputs,
        executable = ctx.attr._scalajs_linker.files_to_run.executable,
        # input_manifests = input_manifests,
        # execution_requirements = _resolve_execution_reqs(ctx, {"no-sandbox": "1", "supports-workers": "1"}),
        # arguments = worker_args + [args],
        arguments = [args],
        use_default_shell_env = True,
    )
    return [DefaultInfo(files = depset(outputs))]

scalajs_link = rule(
    attrs = {
        "data": attr.label_list(
            doc = "The additional runtime files needed by this library.",
            allow_files = True,
        ),
        "deps_used_whitelist": attr.label_list(
            doc = "The JVM library dependencies to always consider used for `scala_deps_used` checks.",
            providers = [JavaInfo],
        ),
        "deps_unused_whitelist": attr.label_list(
            doc = "The JVM library dependencies to always consider unused for `scala_deps_direct` checks.",
            providers = [JavaInfo],
        ),
        "deps": attr.label_list(
            doc = "The JVM library dependencies.",
            providers = [JavaInfo],
        ),
        "scala": attr.label(
            default = "//external:default_scala",
            doc = "The `ScalaConfiguration`. Among other things, this specifies which scala version to use.\n Defaults to the default_scala target specified in the WORKSPACE file.",
            providers = [
                _ScalaConfiguration,
            ],
        ),
        "scalacopts": attr.string_list(
            doc = "The Scalac options.",
        ),
        "main_class": attr.string(default = "auto"),
        "main_method": attr.string(default = "main"),
        "module_kind": attr.string(default = "no-module"),
        "main_method_with_args": attr.bool(default = False),
        "full_opt": attr.bool(default = False),
        "_scalajs_linker": attr.label(
            default = "@rules_scala3//scala/workers/scalajs:scalajs_linker",
            allow_files = True,
            executable = True,
            cfg = "exec",
        ),
    },
    implementation = _scalajs_link_impl,
)
