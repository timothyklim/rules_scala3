load("//rules:scala.bzl", "scala_binary")
load("//rules:scalafmt.bzl", "scala_format_test")

scala_binary(
    name = "compile",
    srcs = glob(["**/*.scala"]),
    main_class = "higherkindness.rules_scala.workers.zinc.compile.ZincRunner",
    scala = "//src/main/scala:bootstrap_3_0_0",
    visibility = ["//visibility:public"],
    runtime_deps = [
        "@annex//:com_lihaoyi_sourcecode_2_13",
    ],
    deps = [
        "@annex//:org_scala_sbt_zinc_2_13",
        "@bazel_src//src/java_tools/buildjar/java/com/google/devtools/build/buildjar/jarhelper",
        "//src/main/scala/higherkindness/rules_scala/common/worker",
        "//src/main/scala/higherkindness/rules_scala/workers/common",
    ],
)

scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)
