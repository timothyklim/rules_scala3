def _scala_deps_impl(ctx):
    deps_bin = ctx.actions.declare_file(ctx.label.name + "_bin.jar")

    ctx.actions.run(
        outputs = [deps_bin],
        inputs = [ctx.file.src],
        executable = ctx.executable._scala_binary,
        arguments = [
            ctx.file.src.path,
            "-d",
            deps_bin.path,
        ],
        mnemonic = "ScalaDepsCompile",
        progress_message = "Compiling Deps.scala to generate dependencies...",
    )

    output_dir = ctx.actions.declare_directory(ctx.label.name + "_3rdparty")

    ctx.actions.run_shell(
        outputs = [output_dir],
        inputs = [deps_bin],
        command = "java -jar {deps_bin} --output {output_dir}".format(
            deps_bin = deps_bin.path,
            output_dir = output_dir.path,
        ),
        mnemonic = "GenerateDeps",
        progress_message = "Generating 3rdparty dependencies directory...",
    )

    return [
        DefaultInfo(files = depset([output_dir])),
    ]

scala_deps = rule(
    implementation = _scala_deps_impl,
    attrs = {
        "src": attr.label(mandatory = True, allow_single_file = True),
        "_scala_binary": attr.label(
            default = Label("//scala_deps/src/bin:scala_deps_binary"),
            cfg = "host",
            executable = True,
        ),
    },
)
