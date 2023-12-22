"A module defining `worker_scala_library` rules"

load("@bazel_skylib//lib:dicts.bzl", _dicts = "dicts")
load("//rules:jvm.bzl", _labeled_jars = "labeled_jars")
load(
    "//rules:private_proxy.bzl",
    _coverage_replacements_provider = "coverage_replacements_provider",
    _phase_classpaths = "phase_classpaths",
    _phase_coda = "phase_coda",
    _phase_coverage_jacoco = "phase_coverage_jacoco",
    _phase_javainfo = "phase_javainfo",
    _phase_library_defaultinfo = "phase_library_defaultinfo",
    _phase_noop = "phase_noop",
    _phase_resources = "phase_resources",
    _phase_singlejar = "phase_singlejar",
    _run_phases = "run_phases",
)
load("//rules:providers.bzl", _ScalaConfiguration = "ScalaConfiguration")

_compile_private_attributes = {
    "_java_toolchain": attr.label(
        default = "@bazel_tools//tools/jdk:current_java_toolchain",
        providers = [java_common.JavaToolchainInfo],
    ),
    "_singlejar": attr.label(
        cfg = "exec",
        default = "@remote_java_tools//:singlejar_cc_bin",
        executable = True,
    ),
    "_jdk": attr.label(
        default = Label("@bazel_tools//tools/jdk:current_java_runtime"),
        providers = [java_common.JavaRuntimeInfo],
        cfg = "exec",
    ),
    "_jar_creator": attr.label(
        default = Label("@remote_java_tools//:ijar_cc_binary"),
        executable = True,
        cfg = "exec",
    ),
}

_runtime_private_attributes = {
    "_target_jdk": attr.label(
        default = Label("@bazel_tools//tools/jdk:current_java_runtime"),
        providers = [java_common.JavaRuntimeInfo],
    ),
    "_java_stub_template": attr.label(
        default = Label("@bazel_tools//tools/java:java_stub_template.txt"),
        allow_single_file = True,
    ),
}

def _worker_scala_library_impl(ctx):
    return _run_phases(ctx, [
        ("resources", _phase_resources),
        ("classpaths", _phase_classpaths),
        ("javainfo", _phase_javainfo),
        ("compile", _phase_noop),
        ("singlejar", _phase_singlejar),
        ("coverage", _phase_coverage_jacoco),
        ("library_defaultinfo", _phase_library_defaultinfo),
        ("coda", _phase_coda),
    ]).coda

worker_scala_library = rule(
    attrs = _dicts.add(
        _compile_private_attributes,
        _runtime_private_attributes,
        {
            "srcs": attr.label_list(
                doc = "The source Scala and Java files (and `.srcjar` files of those).",
                allow_files = [
                    ".scala",
                    ".java",
                    ".srcjar",
                ],
            ),
            "deps": attr.label_list(
                aspects = [
                    _labeled_jars,
                    _coverage_replacements_provider.aspect,
                ],
                doc = "The JVM library dependencies.",
                providers = [JavaInfo],
            ),
            "main_class": attr.string(
                doc = "The main class. If not provided, it will be inferred by its type signature.",
            ),
            "jvm_flags": attr.string_list(
                doc = "The JVM runtime flags.",
            ),
            "neverlink": attr.bool(
                default = False,
                doc = "Whether this library should be excluded at runtime.",
            ),
            "_worker_rule": attr.bool(default = True),
            # TODO should be removed
            "_scala": attr.label(
                default = "//scala:bootstrap_3",
                doc = "The `ScalaConfiguration`. Among other things, this specifies which scala version to use.\n Defaults to the default_scala target specified in the WORKSPACE file.",
                providers = [
                    _ScalaConfiguration,
                ],
            ),
            "plugins": attr.label_list(doc = "The Scalac plugins."),
            "_phase_providers": attr.label_list(),
            "resources": attr.label_list(doc = "The files to include as classpath resources."),
            "runtime_deps": attr.label_list(doc = "The JVM runtime-only library dependencies."),
            "resource_jars": attr.label_list(doc = "The JARs to merge into the output JAR."),
            "data": attr.label_list(doc = "The additional runtime files needed by this library."),
        },
    ),
    doc = "Simplifyed `scala_library` to create workers and avoid recursion.",
    outputs = {
        "jar": "%{name}.jar",
        "src_jar": "%{name}-src.jar",
    },
    implementation = _worker_scala_library_impl,
    toolchains = [
        "@bazel_tools//tools/jdk:toolchain_type",
    ],
)
