workspace(name = "rules_scala3")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

rules_jvm_tag = "4.0"

http_archive(
    name = "rules_jvm_external",
    sha256 = "31d226a6b3f5362b59d261abf9601116094ea4ae2aa9f28789b6c105e4cada68",
    strip_prefix = "rules_jvm_external-" + rules_jvm_tag,
    url = "https://github.com/bazelbuild/rules_jvm_external/archive/{}.tar.gz".format(rules_jvm_tag),
)

load("//rules/scala:workspace.bzl", "scala_register_toolchains", "scala_repositories")

scala_repositories()

load("//rules/scala:init.bzl", "rules_scala3_init")

rules_scala3_init()

load("@annex//:defs.bzl", annex_pinned_maven_install = "pinned_maven_install")

annex_pinned_maven_install()

scala_register_toolchains()

load("//rules/scalafmt:workspace.bzl", "scalafmt_default_config", "scalafmt_repositories")

scalafmt_repositories()

load("@annex_scalafmt//:defs.bzl", annex_scalafmt_pinned_maven_install = "pinned_maven_install")

annex_scalafmt_pinned_maven_install()

scalafmt_default_config(".scalafmt.conf")

load(
    "//rules/scala_proto:workspace.bzl",
    "scala_proto_register_toolchains",
    "scala_proto_repositories",
)

scala_proto_repositories()

scala_proto_register_toolchains()

load("@annex_proto//:defs.bzl", annex_proto_pinned_maven_install = "pinned_maven_install")

annex_proto_pinned_maven_install()
