load("//deps:scala_deps.bzl", "scala_deps")
load("//rules:scala.bzl", "scala_binary")
load("//rules:scala_proto.bzl", "scala_proto_toolchain")

toolchain_type(
    name = "compiler_toolchain_type",
    visibility = ["//visibility:public"],
)

filegroup(
    name = "dependencies",
    srcs = ["Dependencies.scala"],
    visibility = ["//visibility:public"],
)

scala_deps(
    name = "scala_deps",
    src = "//rules/scala_proto:dependencies",
    dependencies = "rules_scala3.rules.scala_proto.Dependencies",
)

scala_binary(
    name = "worker",
    srcs = ["private/ScalaProtoWorker.scala"],
    jvm_flags = ["-Djava.security.manager=allow"],
    main_class = "annex.scala.proto.ScalaProtoWorker",
    scala = "//scala:bootstrap_3",
    visibility = ["//visibility:public"],
    deps = [
        "//3rdparty/jvm/com/github/scopt",
        "//rules/scala_proto/3rdparty/jvm/com/thesamet/scalapb:compilerplugin",
        "//rules/scala_proto/3rdparty/jvm/com/thesamet/scalapb:protoc_bridge",
        "//rules/scala_proto/3rdparty/jvm/com/thesamet/scalapb:protoc_gen",
        "//rules/scala_proto/3rdparty/jvm/com/thesamet/scalapb/grpcweb:scalapb_grpcweb_code_gen",
        "//scala/common/worker",
        "//scala/workers/common",
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
