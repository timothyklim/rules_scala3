"Mezel aspect compatible with `rules_scala3`"

load("@rules_scala3//rules:providers.bzl", "ScalaInfo", "SemanticdbInfo")

BuildTargetInfo = provider(
    doc = "Generate depset of bypassed targets.",
    fields = {
        "output": "output",
    },
)

# should only apply to rules that generate semanticdb (phase_zinc_compile)
# also all rules must contain attrs, which are used here

#"scala_library",
#"scala_binary",
#"scala_test",

#"scalajs_library", # may not work as is
#"scalajs_link", # may not work as is

def _mezel_aspect_impl(target, ctx):
    # TODO check rules
    #print(ctx.rule.kind)

    jdk = ctx.attr._jdk
    target_attrs = ctx.rule.attr
    toolchain = target[ScalaInfo].toolchain

    if not toolchain.enable_semanticdb:
        fail("SemanticDB is not enabled, please set the `enable_semanticdb` attribute to `True` in your `scala_toolchain`", toolchain)

    if toolchain.semanticdb_bundle_in_jar:
        fail("SemanticDB is bundled in the output jar, please generate it separately by setting the `semanticdb_bundle_in_jar` attribute to `False` in your `scala_toolchain`")

    toolchain_opts = toolchain.global_scalacopts if toolchain.global_scalacopts else []
    target_opts = target_attrs.scalacopts if target_attrs.scalacopts else []

    opts = toolchain_opts + target_opts

    # hardcode the latest supported metals version
    compiler_version = "3.3.1"

    semanticdb_target_root = target[SemanticdbInfo].target_root

    scala_compile_classpath = [
        file
        for target in toolchain.compiler_classpath
        for file in target[JavaInfo].compile_jars.to_list()
    ]

    dep_outputs = [
        dependency[BuildTargetInfo].output
        for dependency in target_attrs.deps
        if BuildTargetInfo in dependency
    ]
    direct_dep_labels = [dependency.label for dependency in dep_outputs]

    transitive_labels = depset(
        [target.label],
        transitive = [x.transitive_labels for x in dep_outputs],
    )
    ignore = transitive_labels.to_list()

    output_class_jars = [x.class_jar.path for x in target[JavaInfo].java_outputs]
    if (len(output_class_jars) != 1):
        fail("Expected exactly one output class jar, got {}".format(output_class_jars))
    output_class_jar = output_class_jars[0]

    def non_self(file):
        return file.owner != target.label

    def external_dep(file):
        return file.owner not in ignore

    def depcheck(file):
        return non_self(file) and external_dep(file)

    transitive_compile_jars = target[JavaInfo].transitive_compile_time_jars.to_list()
    cp_jars = [x.path for x in transitive_compile_jars if non_self(x)]
    transitive_source_jars = target[JavaInfo].transitive_source_jars.to_list()
    src_jars = [x.path for x in transitive_source_jars if depcheck(x)]

    raw_plugins = target_attrs.plugins if target_attrs.plugins else []
    plugins = [
        y.path
        for x in raw_plugins
        if JavaInfo in x
        for y in x[JavaInfo].compile_jars.to_list()
    ]

    # generate bsp_info files
    scalac_options_file = ctx.actions.declare_file("{}_bsp_scalac_options.json".format(target.label.name))
    scalac_options_content = struct(
        scalacopts = opts,
        semanticdbPlugin = "",
        plugins = plugins,
        classpath = cp_jars,
        targetroot = semanticdb_target_root,
        outputClassJar = output_class_jar,
        compilerVersion = compiler_version,
    )
    ctx.actions.write(scalac_options_file, json.encode(scalac_options_content))

    sources_file = ctx.actions.declare_file("{}_bsp_sources.json".format(target.label.name))
    sources_content = struct(
        sources = [
            f.path
            for src in target_attrs.srcs
            for f in src.files.to_list()
        ],
    )
    ctx.actions.write(sources_file, json.encode(sources_content))

    dependency_sources_file = ctx.actions.declare_file("{}_bsp_dependency_sources.json".format(target.label.name))
    dependency_sources_content = struct(
        sourcejars = src_jars,
    )
    ctx.actions.write(dependency_sources_file, json.encode(dependency_sources_content))

    build_target_file = ctx.actions.declare_file("{}_bsp_build_target.json".format(target.label.name))
    build_target_content = struct(
        javaHome = jdk[java_common.JavaRuntimeInfo].java_home,
        scalaCompilerClasspath = [x.path for x in scala_compile_classpath],
        compilerVersion = compiler_version,
        deps = [str(label) for label in direct_dep_labels],
        directory = target.label.package,
    )
    ctx.actions.write(build_target_file, json.encode(build_target_content))

    ctx.actions.do_nothing(
        mnemonic = "MezelAspect",
        inputs = [scalac_options_file, sources_file, dependency_sources_file, build_target_file],
    )

    files = struct(
        label = target.label,
        transitive_labels = transitive_labels,
    )

    transitive_output_files = [
        dependency[OutputGroupInfo].bsp_info
        for dependency in target_attrs.deps
        if OutputGroupInfo in dependency and hasattr(dependency[OutputGroupInfo], "bsp_info")
    ]

    transitive_info_deps = [
        target[JavaInfo].transitive_compile_time_jars,
        target[JavaInfo].transitive_source_jars,
    ] + [x[JavaInfo].compile_jars for x in raw_plugins]

    bsp_info_deps = depset(
        [x for x in scala_compile_classpath if depcheck(x)],
        transitive = [depset([x for x in xs.to_list() if depcheck(x)]) for xs in transitive_info_deps],
    )

    return [
        OutputGroupInfo(
            bsp_info = depset(
                [scalac_options_file, sources_file, dependency_sources_file, build_target_file],
                transitive = transitive_output_files,
            ),
            bsp_info_deps = bsp_info_deps,
        ),
        BuildTargetInfo(output = files),
    ]

mezel_aspect = aspect(
    implementation = _mezel_aspect_impl,
    attr_aspects = ["deps"],
    required_aspect_providers = [[JavaInfo, SemanticdbInfo]],
    required_providers = [
        [JavaInfo, ScalaInfo],  # allow non-semanticdb targets to throw an error
        [JavaInfo, SemanticdbInfo, ScalaInfo],
    ],
    attrs = {
        "_jdk": attr.label(
            default = Label("@bazel_tools//tools/jdk:current_java_runtime"),
            providers = [java_common.JavaRuntimeInfo],
        ),
    },
)
