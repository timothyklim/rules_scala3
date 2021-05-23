load("@rules_proto//proto:defs.bzl", "proto_library")

genrule(
    name = "scalapb_proto",
    srcs = [
        "@annex_test//:com_thesamet_scalapb_scalapb_runtime_3",
    ],
    outs = ["scalapb/scalapb.proto"],
    cmd = """
        for src in $(SRCS); do
            unzip -qo $$src scalapb/scalapb.proto -d .
        done
        mv scalapb/scalapb.proto $(OUTS)
    """,
)

proto_library(
    name = "scalapb",
    srcs = ["scalapb/scalapb.proto"],
    strip_import_prefix = "/" + package_name(),
    deps = [
        "@com_google_protobuf//:descriptor_proto",
    ],
    visibility = ["//visibility:public"],
)
