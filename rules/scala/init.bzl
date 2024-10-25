load("@annex_deps//:defs.bzl", "pinned_maven_install")
load("@bazel_features//:deps.bzl", "bazel_features_deps")
load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")
load("@rules_proto//proto:repositories.bzl", "rules_proto_dependencies")
load("@rules_proto//proto:toolchains.bzl", "rules_proto_toolchains")
load("//3rdparty:workspace.bzl", "maven_dependencies")
load("//rules/scala_proto/3rdparty:workspace.bzl", maven_dependencies_scala_proto = "maven_dependencies")
load("//rules/scalafmt:config.bzl", "scalafmt_default_config")
load("//rules/scalafmt/3rdparty:workspace.bzl", maven_dependencies_scalafmt = "maven_dependencies")
load("//scala/3rdparty:workspace.bzl", maven_dependencies_scala = "maven_dependencies")

def load_maven_dependencies():
    maven_dependencies()
    maven_dependencies_scala_proto()
    maven_dependencies_scalafmt()
    maven_dependencies_scala()

def rules_scala3_init():
    protobuf_deps()
    rules_proto_dependencies()
    rules_proto_toolchains()
    bazel_features_deps()

    pinned_maven_install()
    load_maven_dependencies()
    scalafmt_default_config(".scalafmt.conf")
