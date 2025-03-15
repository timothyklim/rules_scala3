load("//rules:scala.bzl", "scala_binary")
load("//rules:scalafmt.bzl", "scala_format_test")

scala_binary(
    name = "repl",
    srcs = glob(["**/*.scala"]),
    main_class = "rules_scala3.workers.zinc.repl.ReplRunner",
    visibility = ["//visibility:public"],
    runtime_deps = [
        "//scala/3rdparty/jvm/org/jline:jline_reader",
    ],
    deps = [
        "//3rdparty/jvm/com/github/scopt",
        "//scala/3rdparty/jvm/org/scala_sbt:compiler_interface",
        "//scala/3rdparty/jvm/org/scala_sbt:util_interface",
        "//scala/3rdparty/jvm/org/scala_sbt:util_logging",
        "//scala/3rdparty/jvm/org/scala_sbt:zinc",
        "//scala/3rdparty/jvm/org/scala_sbt:zinc_classpath",
        "//scala/3rdparty/jvm/org/scala_sbt:zinc_compile_core",
        "//scala/workers/common",
    ],
)

scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)
