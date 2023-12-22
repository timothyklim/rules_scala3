load(
    "//rules:scala.bzl",
    "scala_binary",
)
load(
    "//rules:scala_proto.bzl",
    "scala_proto_toolchain",
)

toolchain_type(
    name = "compiler_toolchain_type",
    visibility = ["//visibility:public"],
)

scala_binary(
    name = "worker",
    srcs = ["private/ScalaProtoWorker.scala"],
    jvm_flags = ["-Djava.security.manager=allow"],
    main_class = "annex.scala.proto.ScalaProtoWorker",
    scala = "//scala:bootstrap_3",
    visibility = ["//visibility:public"],
    deps = [
        "//scala/common/worker",
        "//scala/workers/common",
        "@annex//:com_github_scopt_scopt_3",
        "@annex_proto//:com_thesamet_scalapb_compilerplugin_3",
        "@annex_proto//:com_thesamet_scalapb_grpcweb_scalapb_grpcweb_code_gen_3",
        "@annex_proto//:com_thesamet_scalapb_protoc_bridge_2_13",
    ],
)

scala_proto_toolchain(
    name = "scalapb_scala_proto_toolchain_implementation",
    compiler = ":worker",
    compiler_supports_workers = True,
    visibility = ["//visibility:public"],
)

toolchain(
    name = "scalapb_scala_proto_toolchain",
    toolchain = ":scalapb_scala_proto_toolchain_implementation",
    toolchain_type = "@rules_scala3//rules/scala_proto:compiler_toolchain_type",
    visibility = ["//visibility:public"],
)

filegroup(
    name = "bzl",
    srcs = glob(["**/*.bzl"]),
    visibility = ["//rules:__pkg__"],
)
