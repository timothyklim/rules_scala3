load("//rules:scala.bzl", "scala_binary")
load("//rules:scalafmt.bzl", "scala_format_test")

scala_binary(
    name = "compile",
    srcs = glob(["**/*.scala"]),
    main_class = "rules_scala.workers.zinc.compile.ZincRunner",
    scala = "//scala:bootstrap_3_2",
    visibility = ["//visibility:public"],
    jvm_flags = ["-Djava.security.manager=allow"],
    deps = [
        "//rules/third_party/jarhelper",
        "//scala/common/worker",
        "//scala/workers/common",
        "@annex//:com_github_scopt_scopt_3",
        "@annex//:org_scala_sbt_compiler_interface",
        "@annex//:org_scala_sbt_util_interface",
        "@annex//:org_scala_sbt_zinc_2_13",
        "@annex//:org_scala_sbt_zinc_classpath_2_13",
        "@annex//:org_scala_sbt_zinc_compile_core_2_13",
        "@annex//:org_scala_sbt_zinc_core_2_13",
        "@annex//:org_scala_sbt_zinc_persist_2_13",
        "@annex//:org_scala_sbt_zinc_persist_core_assembly",
    ],
)

scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)
