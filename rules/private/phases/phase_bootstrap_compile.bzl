load(
    "//rules/common:private/utils.bzl",
    _resolve_execution_reqs = "resolve_execution_reqs",
    _strip_margin = "strip_margin",
)

#
# PHASE: bootstrap compile
#
# An alternative compile phase that shells out to scalac directly
#

def phase_bootstrap_compile(ctx, g):
    if g.classpaths.plugin:
        fail("plugins aren't supported for bootstrap_scala rules")
    if g.classpaths.src_jars:
        fail("source jars aren't supported for bootstrap_scala rules")

    inputs = depset(
        ctx.files.srcs,
        transitive = [ctx.attr._jdk[java_common.JavaRuntimeInfo].files, g.classpaths.compile, g.classpaths.compiler],
    )

    compiler_classpath = ":".join([f.path for f in g.classpaths.compiler.to_list()])
    compile_classpath = ":".join([f.path for f in g.classpaths.compile.to_list()])
    srcs = " ".join([f.path for f in g.classpaths.srcs])

    compiler_main_class = "dotty.tools.dotc.Main"
    if "scala3" not in compile_classpath:
        compiler_main_class = "scala.tools.nsc.Main"

    ctx.actions.run_shell(
        inputs = inputs,
        outputs = [g.classpaths.jar],
        command = _strip_margin(
            """
            |set -eo pipefail
            |
            |{java} \\
            |  -Dscala.usejavacp=true \\
            |  -classpath {compiler_classpath} \\
            |  {compiler_main_class} \\
            |  -classpath {compile_classpath} \\
            |  -usejavacp \\
            |  -d {output_jar} \\
            |  {srcs}
            |""".format(
                java = ctx.attr._jdk[java_common.JavaRuntimeInfo].java_executable_exec_path,
                compiler_classpath = compiler_classpath,
                compile_classpath = compile_classpath,
                compiler_main_class = compiler_main_class,
                srcs = srcs,
                output_jar = g.classpaths.jar.path,
            ),
        ),
        execution_requirements = _resolve_execution_reqs(ctx, {}),
    )
