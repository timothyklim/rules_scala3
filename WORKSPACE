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
    url = "https://github.com/bazelbuild/skydoc/archive/{}.zip".format(skydoc_tag),
)

git_repository(
    name = "bazel_skylib",
    commit = "d35e8d7bc6ad7a3a53e9a1d2ec8d3a904cc54ff7",
    remote = "https://github.com/bazelbuild/bazel-skylib",
    shallow_since = "1593183852 +0200",
)

protobuf_tag = "3.15.6"

protobuf_sha256 = "985bb1ca491f0815daad825ef1857b684e0844dc68123626a08351686e8d30c9"

http_archive(
    name = "com_google_protobuf",
    sha256 = protobuf_sha256,
    strip_prefix = "protobuf-{}".format(protobuf_tag),
    type = "zip",
    url = "https://github.com/protocolbuffers/protobuf/archive/v{}.zip".format(protobuf_tag),
)

load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")

protobuf_deps()

jdk_build_file_content = """
filegroup(
    name = "jdk",
    srcs = glob(["**/*"]),
    visibility = ["//visibility:public"],
)
filegroup(
    name = "java",
    srcs = ["bin/java"],
    visibility = ["//visibility:public"],
)
"""

rules_jvm_external_tag = "4.0"

rules_jvm_external_sha256 = "31701ad93dbfe544d597dbe62c9a1fdd76d81d8a9150c2bf1ecf928ecdf97169"

http_archive(
    name = "rules_jvm_external",
    sha256 = rules_jvm_external_sha256,
    strip_prefix = "rules_jvm_external-{}".format(rules_jvm_external_tag),
    url = "https://github.com/bazelbuild/rules_jvm_external/archive/{}.zip".format(rules_jvm_external_tag),
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

bazel_commit = "5d6e59a6da7a74ddc5d9733c9c7e6de6382af1e1"

http_archive(
    name = "bazel_src",
    sha256 = "997bfede9fe04c2cf804c63e1bd3ddfe8c80486690fcc5203d8fffdcb4f3e471",
    strip_prefix = "bazel-{}".format(bazel_commit),
    url = "https://github.com/TimothyKlim/bazel/archive/{}.tar.gz".format(bazel_commit),
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

scala3_version = "3.0.0-RC2"

jvm_maven_import_external(
    name = "scala_compiler_3_0_0",
    artifact = "org.scala-lang:scala3-compiler_3.0.0-RC2:" + scala3_version,
    artifact_sha256 = "7003bdafc4827f3461c502986005644a200a2de94b822c2ca7258077f478e248",
    server_urls = server_urls,
)

jvm_maven_import_external(
    name = "scala_library_3_0_0",
    artifact = "org.scala-lang:scala3-library_3.0.0-RC2:" + scala3_version,
    artifact_sha256 = "e7cf01652b4acc288068f28d24b263b249816b44a382385a82daacc9781bf02c",
    server_urls = server_urls,
)

jvm_maven_import_external(
    name = "scala_tasty_core_3_0_0",
    artifact = "org.scala-lang:tasty-core_3.0.0-RC2:" + scala3_version,
    artifact_sha256 = "4243833ad853bc3d969d93d25bc2faf7afd80f98e79b26336b303c7f735bb0c0",
    server_urls = server_urls,
)

jvm_maven_import_external(
    name = "scala_interfaces_3_0_0",
    artifact = "org.scala-lang:scala3-interfaces:" + scala3_version,
    artifact_sha256 = "db94538a11a84f1ffb97b6275b49dd44182fc1edbab4689b537500f882a77ff1",
    server_urls = server_urls,
)

jvm_maven_import_external(
    name = "scala_sbt_bridge_3_0_0",
    artifact = "org.scala-lang:scala3-sbt-bridge:" + scala3_version,
    artifact_sha256 = "97b7ad2846e27dade57c574f212c1ffcd53027c8ea65a5494eabb46e38fb4517",
    server_urls = server_urls,
)

jvm_maven_import_external(
    name = "scala_asm_9_1_0",
    artifact = "org.scala-lang.modules:scala-asm:9.1.0-scala-1",
    artifact_sha256 = "b85af6cbbd6075c4960177c2c3aa03d53b5221fa58b0bc74a31b72f25595e39f",
    server_urls = server_urls,
)
