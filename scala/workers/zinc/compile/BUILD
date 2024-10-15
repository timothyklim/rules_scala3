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
        "@annex//:org_scala_sbt_compiler_interface",
        "@annex//:org_scala_sbt_util_interface",
        "@annex//:org_scala_sbt_zinc_3",
        "@annex//:org_scala_sbt_zinc_classpath_3",
        "@annex//:org_scala_sbt_zinc_compile_core_3",
        "@annex//:org_scala_sbt_zinc_core_3",
        "@annex//:org_scala_sbt_zinc_persist_3",
        # "@annex//:org_scala_sbt_zinc_persist_core_assembly",
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
        "@annex//:org_scala_sbt_compiler_interface",
        "@annex//:org_scala_sbt_util_interface",
        "@annex//:org_scala_sbt_zinc_3",
        "@annex//:org_scala_sbt_zinc_classpath_3",
        "@annex//:org_scala_sbt_zinc_compile_core_3",
        "@annex//:org_scala_sbt_zinc_core_3",
        "@annex//:org_scala_sbt_zinc_persist_3",
        # "@annex//:org_scala_sbt_zinc_persist_core_assembly",
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
        "@annex//:org_scalameta_munit_3",
        "@rules_scala3//scala/workers/common",
    ],
)
