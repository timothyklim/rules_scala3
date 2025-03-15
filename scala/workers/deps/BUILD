load("//rules:scalafmt.bzl", "scala_format_test")
load("//scala3:defs.bzl", "worker_scala_binary")

worker_scala_binary(
    name = "deps",
    srcs = glob(["**/*.scala"]),
    main_class = "rules_scala3.workers.deps.DepsRunner",
    visibility = ["//visibility:public"],
    deps = [
        "//3rdparty/jvm/com/github/scopt",
        "//scala/common/pretty",
        "//scala/common/worker",
        "//scala/workers/common",
    ],
)

scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)
