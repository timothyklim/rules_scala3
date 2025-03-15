load("@rules_proto//proto:defs.bzl", "proto_library")
load("//rules:scalafmt.bzl", "scala_format_test")
load("//scala3:defs.bzl", "worker_scala_library")

proto_library(
    name = "worker_protocol_proto",
    srcs = [":worker_protocol.proto"],
)

java_proto_library(
    name = "worker_protocol_java_proto",
    deps = [":worker_protocol_proto"],
)

genrule(
    name = "gen_BlockSystemExitAgent.jar",
    srcs = ["BlockSystemExitAgent.java"],
    outs = ["BlockSystemExitAgent.jar"],
    cmd = """
        $(JAVABASE)/bin/javac --enable-preview --release 23 -d agentclasses $(location BlockSystemExitAgent.java)
        cat > agent.mf << EOF
Premain-Class: rules_scala3.common.worker.BlockSystemExitAgent
Can-Retransform-Classes: true
EOF
        $(JAVABASE)/bin/jar --create --file=$(location BlockSystemExitAgent.jar) --manifest=agent.mf -C agentclasses .
    """,
    toolchains = ["@bazel_tools//tools/jdk:current_java_runtime"],
    tools = ["@bazel_tools//tools/jdk:current_java_runtime"],
)

worker_scala_library(
    name = "worker",
    srcs = ["WorkerMain.scala"],
    visibility = ["//visibility:public"],
    jvm_flags = [
        "--enable-preview",
        "-javaagent:$(location BlockSystemExitAgent.jar)",
    ],
    deps = [
        ":worker_protocol_java_proto",
        "//scala/workers/common",
    ],
)

scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)
