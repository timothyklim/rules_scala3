load("//rules:scalafmt.bzl", "scala_format_test")
load("//scala3:defs.bzl", "worker_scala_binary")

worker_scala_binary(
    name = "instrumenter",
    srcs = glob(["**/*.scala"]),
    jvm_flags = ["-Djava.security.manager=allow"],
    main_class = "rules_scala.workers.jacoco.instrumenter.JacocoInstrumenter",
    visibility = ["//visibility:public"],
    deps = [
        "//3rdparty/jvm/com/github/scopt",
        "//scala/3rdparty/jvm/org/jacoco:org_jacoco_core",
        "//scala/common/worker",
    ],
)

scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)
