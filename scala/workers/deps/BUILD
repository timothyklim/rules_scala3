load("//rules:scala.bzl", "scala_binary")
load("//rules:scalafmt.bzl", "scala_format_test")

scala_binary(
    name = "deps",
    srcs = glob(["**/*.scala"]),
    main_class = "rules_scala.workers.deps.DepsRunner",
    scala = "//scala:bootstrap_3_0_0",
    visibility = ["//visibility:public"],
    deps = [
        "@annex//:com_github_julien_truffaut_monocle_core_3_0_0_RC1",
        "@annex//:com_github_scopt_scopt_3_0_0_RC1",
        "//scala/common/worker",
    ],
)

scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)
