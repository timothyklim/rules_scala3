load("@rules_proto//proto:defs.bzl", "proto_library")
load("//rules:scala.bzl", "scala_library", "scala_test")
load("//scala3:defs.bzl", "worker_scala_binary")

proto_library(
    name = "diagnostics_proto",
    srcs = ["protobuf/diagnostics.proto"],
)

java_proto_library(
    name = "diagnostics_java_proto",
    visibility = ["//visibility:public"],
    deps = [":diagnostics_proto"],
)

worker_scala_binary(
    name = "compile",
    srcs = glob(["main/*.scala"]),
    jvm_flags = ["-Djava.security.manager=allow"],
    main_class = "rules_scala.workers.zinc.compile.ZincRunner",
    visibility = ["//visibility:public"],
    deps = [
        ":diagnostics_java_proto",
        "//3rdparty/jvm/com/github/scopt",
        "//scala/3rdparty/jvm/org/scala_sbt:compiler_interface",
        "//scala/3rdparty/jvm/org/scala_sbt:util_interface",
        "//scala/3rdparty/jvm/org/scala_sbt:util_relation",
        "//scala/3rdparty/jvm/org/scala_sbt:zinc",
        "//scala/3rdparty/jvm/org/scala_sbt:zinc_classpath",
        "//scala/3rdparty/jvm/org/scala_sbt:zinc_compile_core",
        "//scala/3rdparty/jvm/org/scala_sbt:zinc_core",
        "//scala/3rdparty/jvm/org/scala_sbt:zinc_persist",
        "@rules_scala3//rules/third_party/jarhelper",
        "@rules_scala3//scala/common/worker",
        "@rules_scala3//scala/workers/common",
    ],
)

scala_library(
    name = "lib",
    srcs = glob(["main/*.scala"]),
    scala = "@//:zinc_3",
    visibility = ["//visibility:public"],
    deps = [
        ":diagnostics_java_proto",
        "//3rdparty/jvm/com/github/scopt",
        "//scala/3rdparty/jvm/org/scala_sbt:compiler_interface",
        "//scala/3rdparty/jvm/org/scala_sbt:util_interface",
        "//scala/3rdparty/jvm/org/scala_sbt:util_relation",
        "//scala/3rdparty/jvm/org/scala_sbt:zinc",
        "//scala/3rdparty/jvm/org/scala_sbt:zinc_classpath",
        "//scala/3rdparty/jvm/org/scala_sbt:zinc_compile_core",
        "//scala/3rdparty/jvm/org/scala_sbt:zinc_core",
        "//scala/3rdparty/jvm/org/scala_sbt:zinc_persist",
        "@rules_scala3//rules/third_party/jarhelper",
        "@rules_scala3//scala/common/worker",
        "@rules_scala3//scala/workers/common",
    ],
)

scala_test(
    name = "tests",
    srcs = glob(["test/*.scala"]),
    scala = "@//:zinc_3",
    deps = [
        ":lib",
        "//scala/3rdparty/jvm/org/scala_sbt:util_relation",
        "//scala/3rdparty/jvm/org/scalameta:munit",
        "//scala/3rdparty/jvm/org/scalameta:munit_diff",
        "@rules_scala3//scala/workers/common",
    ],
)
