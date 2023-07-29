load("@rules_java//java:defs.bzl", "java_binary", "java_library")
load("//rules:scala.bzl", "scala_library")
load("//rules/common:private/utils.bzl", _safe_name = "safe_name")

def _jmh_benchmark(ctx):
    info = ctx.attr.src[JavaInfo]

    input_bytecode_dir = ctx.actions.declare_directory("{}_bytecode".format(_safe_name(ctx.attr.name)))
    output_source_dir = ctx.actions.declare_directory("{}_src".format(_safe_name(ctx.attr.name)))
    output_resource_dir = ctx.actions.declare_directory("{}_resources".format(_safe_name(ctx.attr.name)))

    class_jar = info.outputs.jars[0].class_jar
    ctx.actions.run_shell(
        inputs = [class_jar],
        outputs = [input_bytecode_dir],
        arguments = [class_jar.path, input_bytecode_dir.path],
        command = "unzip $1 -d $2",
        progress_message = "Unzip classes from jar",
        use_default_shell_env = True,
    )
    ctx.actions.run(
        outputs = [output_source_dir, output_resource_dir],
        inputs = [input_bytecode_dir],
        executable = ctx.executable._generator,
        arguments = [input_bytecode_dir.path, output_source_dir.path, output_resource_dir.path, ctx.attr.generator_type],
        progress_message = "Generating benchmark code for %s" % ctx.label,
    )
    ctx.actions.run_shell(
        inputs = [output_source_dir],
        outputs = [ctx.outputs.srcjar],
        arguments = [ctx.executable._zipper.path, output_source_dir.path, output_source_dir.short_path, ctx.outputs.srcjar.path],
        command = """$1 c $4 META-INF/= $(find -L $2 -type f | while read v; do echo ${v#"$2/"}=$v; done)""",
        progress_message = "Bundling generated Java sources into srcjar",
        tools = [ctx.executable._zipper],
        use_default_shell_env = True,
    )
    ctx.actions.run_shell(
        inputs = [output_resource_dir],
        outputs = [ctx.outputs.resources_jar],
        arguments = [ctx.executable._zipper.path, output_resource_dir.path, output_resource_dir.short_path, ctx.outputs.resources_jar.path],
        command = """$1 c $4 META-INF/= $(find -L $2 -type f | while read v; do echo ${v#"$2/"}=$v; done)""",
        progress_message = "Bundling generated resources into jar",
        tools = [ctx.executable._zipper],
        use_default_shell_env = True,
    )

generate_jmh_benchmark = rule(
    implementation = _jmh_benchmark,
    attrs = {
        "src": attr.label(mandatory = True, providers = [[JavaInfo]]),
        "generator_type": attr.string(
            default = "asm",
            mandatory = False,
        ),
        "_generator": attr.label(executable = True, cfg = "exec", default = "@//jmh:generator"),
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
          "@//3rdparty/jvm/org/openjdk/jmh:jmh_core",
      ],
      runtime_deps = kwargs.get("runtime_deps", []),
      resources = kwargs.get("resources", []),
      resource_jars = kwargs.get("resource_jars", []),
      scala = "//scala:bootstrap_3_3",
  )

  codegen = name + "_codegen"
  generate_jmh_benchmark(
      name = codegen,
      src = lib,
      generator_type = kwargs.get("generator_type", "asm"),
  )
  compiled_lib = name + "_compiled_jmh_lib"
  java_library(
      name = compiled_lib,
      srcs = ["%s.srcjar" % codegen],
      deps = deps + [
          "@//3rdparty/jvm/org/openjdk/jmh:jmh_core",
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
