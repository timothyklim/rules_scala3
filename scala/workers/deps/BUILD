load("//rules:scalafmt.bzl", "scala_format_test")
load("//scala3:defs.bzl", "worker_scala_binary")

worker_scala_binary(
    name = "deps",
    srcs = glob(["**/*.scala"]),
    jvm_flags = ["-Djava.security.manager=allow"],
    main_class = "rules_scala.workers.deps.DepsRunner",
    visibility = ["//visibility:public"],
    deps = [
        "//scala/common/worker",
        "//scala/workers/common",
        "@annex//:com_github_scopt_scopt_3",
    ],
)

scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)
