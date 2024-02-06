load("//rules:scala.bzl", "scala_test", "scala_library")
load("//scala3:defs.bzl", "worker_scala_binary")

worker_scala_binary(
    name = "compile",
    srcs = glob(["main/*.scala"]),
    jvm_flags = ["-Djava.security.manager=allow"],
    main_class = "rules_scala.workers.zinc.compile.ZincRunner",
    visibility = ["//visibility:public"],
    deps = [
        "@annex//:com_github_scopt_scopt_3",
        "@annex//:org_scala_sbt_compiler_interface",
        "@annex//:org_scala_sbt_util_interface",
        "@annex//:org_scala_sbt_zinc_3",
        "@annex//:org_scala_sbt_zinc_classpath_3",
        "@annex//:org_scala_sbt_zinc_compile_core_3",
        "@annex//:org_scala_sbt_zinc_core_3",
        "@annex//:org_scala_sbt_zinc_persist_3",
        "@annex//:org_scala_sbt_zinc_persist_core_assembly",
        "@rules_scala3//rules/third_party/jarhelper",
        "@rules_scala3//scala/common/worker",
        "@rules_scala3//scala/workers/common",
    ],
)

scala_library(
    name = "lib",
    srcs = glob(["main/*.scala"]),
    visibility = ["//visibility:public"],
    deps = [
        "@annex//:com_github_scopt_scopt_3",
        "@annex//:org_scala_sbt_compiler_interface",
        "@annex//:org_scala_sbt_util_interface",
        "@annex//:org_scala_sbt_zinc_3",
        "@annex//:org_scala_sbt_zinc_classpath_3",
        "@annex//:org_scala_sbt_zinc_compile_core_3",
        "@annex//:org_scala_sbt_zinc_core_3",
        "@annex//:org_scala_sbt_zinc_persist_3",
        "@annex//:org_scala_sbt_zinc_persist_core_assembly",
        "@rules_scala3//rules/third_party/jarhelper",
        "@rules_scala3//scala/common/worker",
        "@rules_scala3//scala/workers/common",
    ],
    scala = "@//:zinc_3",
)

scala_test(
    name = "tests",
    srcs = glob(["test/*.scala"]),
    deps = [
        ":lib",
        "@annex//:org_scalameta_munit_3",
        "@rules_scala3//scala/workers/common",
    ],
    scala = "@//:zinc_3",
)
