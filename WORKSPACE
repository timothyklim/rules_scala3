workspace(name = "rules_scala3")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "bazel_features",
    sha256 = "091d8b1e1f0bf1f7bd688b95007687e862cc489f8d9bc21c14be5fd032a8362f",
    strip_prefix = "bazel_features-1.26.0",
    url = "https://github.com/bazel-contrib/bazel_features/releases/download/v1.26.0/bazel_features-v1.26.0.tar.gz",
)
load("@bazel_features//:deps.bzl", "bazel_features_deps")
bazel_features_deps()

http_archive(
    name = "rules_java",
    urls = [
        "https://github.com/bazelbuild/rules_java/releases/download/8.6.3/rules_java-8.6.3.tar.gz",
    ],
    sha256 = "6d8c6d5cd86fed031ee48424f238fa35f33abc9921fd97dd4ae1119a29fc807f",
)

load("@rules_java//java:rules_java_deps.bzl", "rules_java_dependencies")
rules_java_dependencies()

load("@com_google_protobuf//bazel/private:proto_bazel_features.bzl", "proto_bazel_features")  # buildifier: disable=bzl-visibility
proto_bazel_features(name = "proto_bazel_features")

load("@rules_java//java:repositories.bzl", "rules_java_toolchains")
rules_java_toolchains()

load("//rules/scala:workspace.bzl", "scala_register_toolchains", "scala_repositories")

scala_repositories()

load("//rules/scala:init.bzl", "rules_scala3_init")

rules_scala3_init()

scala_register_toolchains(default_compiler = "bootstrap")

# load("//mezel_compatibility:repositories.bzl", "mezel_compatibility_repository")

# mezel_compatibility_repository(
#     name = "mezel",
#     mezel_version = "216327ab2fc6d5866f13ace1bf75c9d1abdcd8a6",
#     sha256 = "dbdb144fc943670dc1b715629f939d8f5010ae1b2ab889b3620866ce19cda1df",
# )

# load("@mezel//rules:load_mezel.bzl", "load_mezel")

# load_mezel()
