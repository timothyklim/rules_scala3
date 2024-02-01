"A module containing some constants related to the toolchain"

SCALA_TOOLCHAIN_ATTRS = {
    "enable_semanticdb": attr.bool(
        default = False,
        doc = "Enable SemanticDB.",
    ),
    "semanticdb_bundle_in_jar": attr.bool(
        default = False,
        doc = "Whether semanticdb should be generated inside the output jar file or separately.",
    ),
    "is_zinc": attr.bool(
        default = True,
        doc = "Use zinc compiler?",
    ),
    "zinc_log_level": attr.string(
        default = "warn",
        doc = "Zinc compiler log level.",
    ),
    "compiler_bridge": attr.label(
        allow_single_file = True,
        mandatory = True,
        doc = "Set zinc compiler bridge.",
    ),
    "compiler_classpath": attr.label_list(
        mandatory = True,
        doc = "Sets compiler classpath.",
        providers = [JavaInfo],
    ),
    "runtime_classpath": attr.label_list(
        mandatory = True,
        doc = "Sets runtime classpath.",
        providers = [JavaInfo],
    ),
    "global_plugins": attr.label_list(
        doc = "Sets compiler plugins for all targets using this toolchain.",
    ),
    "global_scalacopts": attr.string_list(
        doc = "Sets scalac options for all targets using this toolchain.",
    ),
    "global_jvm_flags": attr.string_list(
        doc = "Sets JVM flags for all targets using this toolchain.",
    ),
    "_compile_worker": attr.label(
        default = "@rules_scala3//scala/workers/zinc/compile",
        allow_files = True,
        executable = True,
        cfg = "exec",
    ),
    "_code_coverage_instrumentation_worker": attr.label(
        default = "@rules_scala3//scala/workers/jacoco/instrumenter",
        allow_files = True,
        executable = True,
        cfg = "exec",
    ),
    "_deps_worker": attr.label(
        default = "@rules_scala3//scala/workers/deps",
        allow_files = True,
        executable = True,
        cfg = "exec",
    ),
    "deps_direct": attr.string(
        default = "error",
        doc = """Require that direct usages of libraries come only from
        immediately declared deps. One of: off, warn, error.
        """,
    ),
    "deps_used": attr.string(
        default = "error",
        doc = """Require that any immediate deps are deps are directly used.
        One of: off, warn, error.
        """,
    ),
}

UNMANDATORY_TOOLCHAIN_ATTRS = SCALA_TOOLCHAIN_ATTRS | {
    "compiler_bridge": attr.label(
        doc = "Set zinc compiler bridge.",
    ),
    "compiler_classpath": attr.string_list(
        doc = "Sets compiler classpath.",
    ),
    "runtime_classpath": attr.string_list(
        doc = "Sets runtime classpath.",
    ),
    "global_plugins": attr.string_list(
        doc = "Sets compiler plugins for all targets using this toolchain.",
    ),
}
