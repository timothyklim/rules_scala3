load("//rules:scala.bzl", "scala_binary")
load("//rules:scalafmt.bzl", "scala_format_test")

scala_binary(
    name = "deps",
    srcs = glob(["**/*.scala"]),
    main_class = "rules_scala.workers.deps.DepsRunner",
    scala = "//scala:bootstrap_3_0_0",
    visibility = ["//visibility:public"],
    deps = [
        "//scala/common/worker",
        "@annex//:net_sourceforge_argparse4j_argparse4j",
    ],
)

scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)
