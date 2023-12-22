load("@rules_java//java:defs.bzl", "java_binary", "java_library")
load("@rules_scala3//rules:scala.bzl", "scala_library")
load("@rules_scala3//rules/common:private/utils.bzl", _safe_name = "safe_name")

def _jmh_benchmark(ctx):
    tmp = ctx.actions.declare_directory("{}/tmp".format(_safe_name(ctx.label.name)))

    info = ctx.attr.src[JavaInfo]
    cp = [info.outputs.jars[0].class_jar] + info.transitive_runtime_jars.to_list()

    args = ctx.actions.args()
    args.add_all([j.path for j in cp], format_each = "--cp=%s")
    args.add("--generator", ctx.attr.generator_type)
    args.add("--sources_jar", ctx.outputs.srcjar.path)
    args.add("--resources_jar", ctx.outputs.resources_jar.path)
    args.add("--tmp", tmp.path)
    ctx.actions.run(
        outputs = [ctx.outputs.srcjar, ctx.outputs.resources_jar, tmp],
        inputs = cp,
        executable = ctx.executable._runner,
        arguments = [args],
        progress_message = "Generating JMH code for %s" % ctx.label,
    )

generate_jmh_benchmark = rule(
    implementation = _jmh_benchmark,
    attrs = {
        "src": attr.label(mandatory = True, providers = [[JavaInfo]]),
        "generator_type": attr.string(
            default = "default",
            mandatory = False,
        ),
        "_runner": attr.label(executable = True, cfg = "exec", default = "@rules_scala3//jmh:runner"),
        "_zipper": attr.label(cfg = "exec", default = "@bazel_tools//tools/zip:zipper", executable = True),
    },
    outputs = {
        "srcjar": "%{name}.srcjar",
        "resources_jar": "%{name}_resources.jar",
    },
)

def scala_jmh_benchmark(**kwargs):
    name = kwargs["name"]
    deps = kwargs.get("deps", [])
    lib = "%s_generator" % name

    scala_library(
        name = lib,
        srcs = kwargs["srcs"],
        deps = deps + [
            "@rules_scala3//3rdparty/jvm/org/openjdk/jmh:jmh_core",
        ],
        runtime_deps = kwargs.get("runtime_deps", []),
        resources = kwargs.get("resources", []),
        resource_jars = kwargs.get("resource_jars", []),
        scala = "@rules_scala3//scala:bootstrap_3",
    )

    codegen = name + "_codegen"
    generate_jmh_benchmark(
        name = codegen,
        src = lib,
        generator_type = kwargs.get("generator_type", "default"),
    )
    compiled_lib = name + "_compiled_jmh_lib"
    java_library(
        name = compiled_lib,
        srcs = ["%s.srcjar" % codegen],
        deps = deps + [
            "@rules_scala3//3rdparty/jvm/org/openjdk/jmh:jmh_core",
            lib,
        ],
        runtime_deps = ["%s_resources.jar" % codegen],
    )
    java_binary(
        name = name,
        runtime_deps = [compiled_lib],
        data = kwargs.get("data", []),
        main_class = "org.openjdk.jmh.Main",
    )
