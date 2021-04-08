workspace(name = "rules_scala3")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("@bazel_tools//tools/build_defs/repo:jvm.bzl", "jvm_maven_import_external")

skydoc_tag = "0.3.0"

skydoc_sha256 = "8762a212cff5f81505a1632630edcfe9adce381479a50a03c968bd2fc217972d"

http_archive(
    name = "io_bazel_skydoc",
    sha256 = skydoc_sha256,
    strip_prefix = "skydoc-{}".format(skydoc_tag),
    url = "https://github.com/bazelbuild/skydoc/archive/{}.tar.gz".format(skydoc_tag),
)

git_repository(
    name = "bazel_skylib",
    commit = "398f3122891b9b711f5aab1adc7597d9fce09085",
    remote = "https://github.com/bazelbuild/bazel-skylib",
    # shallow_since = "1593183852 +0200",
)

protobuf_tag = "3.15.7"

protobuf_sha256 = "efdd6b932a2c0a88a90c4c80f88e4b2e1bf031e7514dbb5a5db5d0bf4f295504"

http_archive(
    name = "com_google_protobuf",
    sha256 = protobuf_sha256,
    strip_prefix = "protobuf-{}".format(protobuf_tag),
    url = "https://github.com/protocolbuffers/protobuf/archive/v{}.tar.gz".format(protobuf_tag),
)

load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")

protobuf_deps()

rules_jvm_external_tag = "4.0"

rules_jvm_external_sha256 = "31d226a6b3f5362b59d261abf9601116094ea4ae2aa9f28789b6c105e4cada68"

http_archive(
    name = "rules_jvm_external",
    sha256 = rules_jvm_external_sha256,
    strip_prefix = "rules_jvm_external-{}".format(rules_jvm_external_tag),
    url = "https://github.com/bazelbuild/rules_jvm_external/archive/{}.tar.gz".format(rules_jvm_external_tag),
)

load("//rules/scala:workspace.bzl", "scala_register_toolchains", "scala_repositories")

scala_repositories()

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

bazel_commit = "4.0.0"

http_archive(
    name = "bazel",
    sha256 = "2b9999d06466815ab1f2eb9c6fc6fceb6061efc715b4086fa99eac041976fb4f",
    strip_prefix = "bazel-{}".format(bazel_commit),
    url = "https://github.com/bazelbuild/bazel/archive/{}.tar.gz".format(bazel_commit),
)

scala2_version = "2.13.6-bin-107c727"

server_urls = [
    "https://repo1.maven.org/maven2",
    "https://scala-ci.typesafe.com/artifactory/scala-integration/",
]

jvm_maven_import_external(
    name = "scala_compiler_2_13_5",
    artifact = "org.scala-lang:scala-compiler:" + scala2_version,
    artifact_sha256 = "61a1d7765b716e29bddcc05d5c8bcb8caf68745016b50b4d00f4a895808044f6",
    server_urls = server_urls,
)

jvm_maven_import_external(
    name = "scala_library_2_13_5",
    artifact = "org.scala-lang:scala-library:" + scala2_version,
    artifact_sha256 = "7e4ea50c2abdd7e7c9d58df823354b765c5efb797ae9550a959b7f47e6ad18c2",
    server_urls = server_urls,
)

jvm_maven_import_external(
    name = "scala_reflect_2_13_5",
    artifact = "org.scala-lang:scala-reflect:" + scala2_version,
    artifact_sha256 = "53f5c2de8beab1093f458866dbbc86a1ce8e570f47768b037d09a054347e0096",
    server_urls = server_urls,
)

scala3_version = "3.0.0-RC1"

jvm_maven_import_external(
    name = "scala_compiler_3_0_0",
    artifact = "org.scala-lang:scala3-compiler_3.0.0-RC1:" + scala3_version,
    artifact_sha256 = "d1f6c9d56b31ebd3e643284ef49643a40a563eb24c026c9b3806f208beeded42",
    server_urls = server_urls,
)

jvm_maven_import_external(
    name = "scala_library_3_0_0",
    artifact = "org.scala-lang:scala3-library_3.0.0-RC1:" + scala3_version,
    artifact_sha256 = "0fc5fa72f30f6c789cbe000d1fbebbc6ae927c73c1058d0f18871a9b3b79fc66",
    server_urls = server_urls,
)

jvm_maven_import_external(
    name = "scala_tasty_core_3_0_0",
    artifact = "org.scala-lang:tasty-core_3.0.0-RC1:" + scala3_version,
    artifact_sha256 = "c485550b896a18a5ddcb9a95846a6d7ea6b9d4ae8e93b8937681eefeb7f20e77",
    server_urls = server_urls,
)

jvm_maven_import_external(
    name = "scala_interfaces_3_0_0",
    artifact = "org.scala-lang:scala3-interfaces:" + scala3_version,
    artifact_sha256 = "6960bca56897940acc2183f0316360fca0d49cd3dfcdd660b524766c36e573a0",
    server_urls = server_urls,
)

jvm_maven_import_external(
    name = "scala_sbt_bridge_3_0_0",
    artifact = "org.scala-lang:scala3-sbt-bridge:" + scala3_version,
    artifact_sha256 = "361f373f3967c6816a220498e0f0ca4c54d9c65a32b4a4c1877a7060d4ba8282",
    server_urls = server_urls,
)

jvm_maven_import_external(
    name = "scala_asm_9_1_0",
    artifact = "org.scala-lang.modules:scala-asm:9.1.0-scala-1",
    artifact_sha256 = "b85af6cbbd6075c4960177c2c3aa03d53b5221fa58b0bc74a31b72f25595e39f",
    server_urls = server_urls,
)
