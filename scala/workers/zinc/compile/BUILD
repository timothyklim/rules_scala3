load("//scala3:defs.bzl", "worker_scala_binary")
load("//rules:scalafmt.bzl", "scala_format_test")

worker_scala_binary(
    name = "compile",
    srcs = glob(["**/*.scala"]),
    jvm_flags = ["-Djava.security.manager=allow"],
    main_class = "rules_scala.workers.zinc.compile.ZincRunner",
    visibility = ["//visibility:public"],
    deps = [
        "@annex//:com_github_scopt_scopt_3",
        "@annex//:org_scala_sbt_compiler_interface",
        "@annex//:org_scala_sbt_util_interface",
        "@annex//:org_scala_sbt_zinc_2_13",
        "@annex//:org_scala_sbt_zinc_classpath_2_13",
        "@annex//:org_scala_sbt_zinc_compile_core_2_13",
        "@annex//:org_scala_sbt_zinc_core_2_13",
        "@annex//:org_scala_sbt_zinc_persist_2_13",
        "@annex//:org_scala_sbt_zinc_persist_core_assembly",
        "@rules_scala3//rules/third_party/jarhelper",
        "@rules_scala3//scala/common/worker",
        "@rules_scala3//scala/workers/common",
    ],
)

scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)
