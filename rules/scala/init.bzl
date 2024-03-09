load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")
load("@rules_proto//proto:repositories.bzl", "rules_proto_dependencies")
load("@rules_proto//proto:toolchains.bzl", "rules_proto_toolchains")

def rules_scala3_init():
    protobuf_deps()

    rules_proto_dependencies()
    rules_proto_toolchains()
