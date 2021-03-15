workspace(name = "rules_scala")

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

scala2_version = "2.13.5"

server_urls = [
    "https://repo1.maven.org/maven2",
    "https://scala-ci.typesafe.com/artifactory/scala-integration/",
]

jvm_maven_import_external(
    name = "scala_compiler_2_13_5",
    artifact = "org.scala-lang:scala-compiler:" + scala2_version,
    artifact_sha256 = "ea7423f3bc3673845d6d1c64335a4645abba0b0478ae00e15979915826ff6116",
    server_urls = server_urls,
)

jvm_maven_import_external(
    name = "scala_library_2_13_5",
    artifact = "org.scala-lang:scala-library:" + scala2_version,
    artifact_sha256 = "52aafeef8e0d104433329b1bc31463d1b4a9e2b8f24f85432c8cfaed9fad2587",
    server_urls = server_urls,
)

jvm_maven_import_external(
    name = "scala_reflect_2_13_5",
    artifact = "org.scala-lang:scala-reflect:" + scala2_version,
    artifact_sha256 = "808c44b8adb3205e91d417bf57406715ca2508ad6952f6e2132ff8099b78bd73",
    server_urls = server_urls,
)

scala3_version = "3.0.0-RC1"

jvm_maven_import_external(
    name = "scala_compiler_3_0_0",
    artifact = "org.scala-lang:scala3-compiler_3.0.0-RC1:" + scala3_version,
    artifact_sha256 = "d1f6c9d56b31ebd3e643284ef49643a40a563eb24c026c9b3806f208beeded42",
    licenses = ["notice"],
    server_urls = ["https://repo.maven.apache.org/maven2"],
)

jvm_maven_import_external(
    name = "scala_library_3_0_0",
    artifact = "org.scala-lang:scala3-library_3.0.0-RC1:" + scala3_version,
    artifact_sha256 = "0fc5fa72f30f6c789cbe000d1fbebbc6ae927c73c1058d0f18871a9b3b79fc66",
    licenses = ["notice"],
    server_urls = ["https://repo.maven.apache.org/maven2"],
)

jvm_maven_import_external(
    name = "scala_tasty_core_3_0_0",
    artifact = "org.scala-lang:tasty-core_3.0.0-RC1:" + scala3_version,
    artifact_sha256 = "c485550b896a18a5ddcb9a95846a6d7ea6b9d4ae8e93b8937681eefeb7f20e77",
    licenses = ["notice"],
    server_urls = ["https://repo.maven.apache.org/maven2"],
)

jvm_maven_import_external(
    name = "scala_interfaces_3_0_0",
    artifact = "org.scala-lang:scala3-interfaces:" + scala3_version,
    artifact_sha256 = "6960bca56897940acc2183f0316360fca0d49cd3dfcdd660b524766c36e573a0",
    licenses = ["notice"],
    server_urls = ["https://repo.maven.apache.org/maven2"],
)

jvm_maven_import_external(
    name = "scala_sbt_bridge_3_0_0",
    artifact = "org.scala-lang:scala3-sbt-bridge:" + scala3_version,
    artifact_sha256 = "361f373f3967c6816a220498e0f0ca4c54d9c65a32b4a4c1877a7060d4ba8282",
    licenses = ["notice"],
    server_urls = ["https://repo.maven.apache.org/maven2"],
)

jvm_maven_import_external(
    name = "scala_asm_9_1_0",
    artifact = "org.scala-lang.modules:scala-asm:9.1.0-scala-1",
    artifact_sha256 = "b85af6cbbd6075c4960177c2c3aa03d53b5221fa58b0bc74a31b72f25595e39f",
    licenses = ["notice"],
    server_urls = ["https://repo.maven.apache.org/maven2"],
)
