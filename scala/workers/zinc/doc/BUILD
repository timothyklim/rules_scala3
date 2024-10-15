load("//rules:scala.bzl", "scala_binary")
load("//rules:scalafmt.bzl", "scala_format_test")

scala_binary(
    name = "doc",
    srcs = glob(["**/*.scala"]),
    jvm_flags = ["-Djava.security.manager=allow"],
    main_class = "rules_scala.workers.zinc.doc.DocRunner",
    visibility = ["//visibility:public"],
    deps = [
        "//3rdparty/jvm/com/github/scopt",
        "//scala/common/worker",
        "//scala/workers/common",
        "@annex//:org_scala_sbt_compiler_interface",
        "@annex//:org_scala_sbt_util_interface",
        "@annex//:org_scala_sbt_util_logging_3",
        "@annex//:org_scala_sbt_zinc_3",
        "@annex//:org_scala_sbt_zinc_classpath_3",
        "@annex//:org_scala_sbt_zinc_compile_core_3",
    ],
)

scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)
