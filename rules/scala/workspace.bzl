load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:jvm.bzl", "jvm_maven_import_external")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("@rules_jvm_external//:defs.bzl", "maven_install")

_SRC_FILEGROUP_BUILD_FILE_CONTENT = """
filegroup(
    name = "src",
    srcs = glob(["**/*.scala", "**/*.java"]),
    visibility = ["//visibility:public"]
)

filegroup(
    name = "meta",
    srcs = glob(["META-INF/**"], allow_empty = False),
    visibility = ["//visibility:public"]
)
"""

repositories = [
    "https://repo1.maven.org/maven2",
    "https://repo.maven.apache.org/maven2",
    "https://maven-central.storage-download.googleapis.com/maven2",
    "https://mirror.bazel.build/repo1.maven.org/maven2",
    "https://scala-ci.typesafe.com/artifactory/scala-integration/",
]

sbt_version = "1.8.0"
zinc_version = "1.8.0"

def scala_artifacts():
    return [
        "com.github.scopt:scopt_3:4.1.0",
        "org.jacoco:org.jacoco.core:0.8.7",
        "org.scala-lang.modules:scala-xml_3:2.1.0",
        "org.scala-sbt:test-interface:1.0",
        "org.scala-sbt:util-interface:" + sbt_version,
        "org.scala-sbt:util-logging_2.13:" + sbt_version,
        "org.scala-sbt:zinc_2.13:" + zinc_version,
    ]

def scala_repositories():
    maven_install(
        name = "annex",
        artifacts = scala_artifacts(),
        repositories = repositories,
        fetch_sources = True,
        maven_install_json = "@rules_scala3//:annex_install.json",
    )

    http_archive(
        name = "compiler_bridge_2_13",
        build_file_content = _SRC_FILEGROUP_BUILD_FILE_CONTENT,
        url = "https://repo.maven.apache.org/maven2/org/scala-sbt/compiler-bridge_2.13/{}/compiler-bridge_2.13-{}-sources.jar".format(zinc_version, zinc_version),
    )

    scala2 = "2.13.10"
    scala3 = "3.2.1"
    scalajs = "1.11.0"

    direct_deps = [
        ["scala_compiler_2_13_10", "org.scala-lang:scala-compiler:" + scala2],
        ["scala_library_2_13_10", "org.scala-lang:scala-library:" + scala2],
        ["scala_reflect_2_13_10", "org.scala-lang:scala-reflect:" + scala2],
        ["scala_compiler_3_2_0", "org.scala-lang:scala3-compiler_3:" + scala3],
        ["scala_interfaces_3_2_0", "org.scala-lang:scala3-interfaces:" + scala3],
        ["scala_library_3_2_0", "org.scala-lang:scala3-library_3:" + scala3],
        ["scala_sbt_bridge_3_2_0", "org.scala-lang:scala3-sbt-bridge:" + scala3],
        ["scala_tasty_core_3_2_0", "org.scala-lang:tasty-core_3:" + scala3],
        ["scala_asm_9_3_0", "org.scala-lang.modules:scala-asm:9.3.0-scala-1"],
        ["scalajs_parallel_collections_1_0_4", "org.scala-lang.modules:scala-parallel-collections_2.13:1.0.4"],
        ["scalajs_compiler_2_13", "org.scala-js:scalajs-compiler_2.13:" + scalajs],
        ["scalajs_env_nodejs_2_13", "org.scala-js:scalajs-env-nodejs_2.13:1.2.1"],
        ["scalajs_ir_2_13", "org.scala-js:scalajs-ir_2.13:" + scalajs],
        ["scalajs_js_envs_2_13", "org.scala-js:scalajs-js-envs_2.13:1.2.1"],
        ["scalajs_library_2_13", "org.scala-js:scalajs-library_2.13:" + scalajs],
        ["scalajs_linker_2_13", "org.scala-js:scalajs-linker_2.13:" + scalajs],
        ["scalajs_linker_interface_2_13", "org.scala-js:scalajs-linker-interface_2.13:" + scalajs],
        ["scalajs_logging_2_13", "org.scala-js:scalajs-logging_2.13:1.1.1"],
        ["scalajs_sbt_test_adapter_2_13", "org.scala-js:scalajs-sbt-test-adapter_2.13:" + scalajs],
        ["scalajs_test_bridge_2_13", "org.scala-js:scalajs-test-bridge_2.13:" + scalajs],
        ["scalajs_test_interface_2_13", "org.scala-js:scalajs-test-interface_2.13:" + scalajs],
        ["scalajs_library_3_2_0_sjs", "org.scala-lang:scala3-library_sjs1_3:" + scala3],
        ["scalajs_tools_2_13", "org.scala-js:scalajs-tools_2.13:0.6.33"],
    ]
    for dep in direct_deps:
        maybe(jvm_maven_import_external, name = dep[0], artifact = dep[1], artifact_sha256 = dep[2] if len(dep) == 3 else "", server_urls = repositories)

    protobuf_tag = "21.5"
    rules_proto_tag = "4.0.0-3.20.0"
    skylib_tag = "1.3.0"
    rules_deps = [
        ["bazel_skylib", None, "https://github.com/bazelbuild/bazel-skylib/releases/download/{version}/bazel-skylib-{version}.tar.gz".format(version = skylib_tag), "74d544d96f4a5bb630d465ca8bbcfe231e3594e5aae57e1edbf17a6eb3ca2506"],
        ["com_google_protobuf", "protobuf-" + protobuf_tag, "https://github.com/protocolbuffers/protobuf/archive/v{}.tar.gz".format(protobuf_tag), "4a7e87e4166c358c63342dddcde6312faee06ea9d5bb4e2fa87d3478076f6639"],
        ["rules_proto", "rules_proto-" + rules_proto_tag, "https://github.com/bazelbuild/rules_proto/archive/{}.tar.gz".format(rules_proto_tag), "e017528fd1c91c5a33f15493e3a398181a9e821a804eb7ff5acdd1d2d6c2b18d"],
    ]
    for dep in rules_deps:
        maybe(http_archive, name = dep[0], strip_prefix = dep[1], url = dep[2], sha256 = dep[3] if len(dep) == 4 else "")

def scala_register_toolchains():
    # reserved for future use
    return ()
