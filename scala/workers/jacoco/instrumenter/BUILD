load("//rules:scala.bzl", "scala_binary")
load("//rules:scalafmt.bzl", "scala_format_test")

scala_binary(
    name = "instrumenter",
    srcs = glob(["**/*.scala"]),
    main_class = "rules_scala.workers.jacoco.instrumenter.JacocoInstrumenter",
    scala = "//scala:bootstrap_3_0_0",
    visibility = ["//visibility:public"],
    deps = [
        "//scala/common/worker",
        "@annex//:com_github_scopt_scopt_3_0_0_RC2",
        "@annex//:org_jacoco_org_jacoco_core",
    ],
)

scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)
