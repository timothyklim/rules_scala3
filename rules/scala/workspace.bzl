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

sbt_version = "1.6.2"
zinc_version = "1.6.1"

def scala_artifacts():
    return [
        "com.github.scopt:scopt_3:4.0.1",
        "org.jacoco:org.jacoco.core:0.8.7",
        "org.scala-lang.modules:scala-xml_3:2.0.1",
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
        sha256 = "2a52d15b3b84da6057fa48a2fa20f8eb6291da78adadd4f42682aa6350272cf2",
        url = "https://repo.maven.apache.org/maven2/org/scala-sbt/compiler-bridge_2.13/{}/compiler-bridge_2.13-{}-sources.jar".format(zinc_version, zinc_version),
    )

    scala2 = "2.13.8"
    scala3 = "3.1.1"
    scalajs = "1.9.0"

    direct_deps = [
        ["scala_compiler_2_13_8", "org.scala-lang:scala-compiler:" + scala2],
        ["scala_library_2_13_8", "org.scala-lang:scala-library:" + scala2],
        ["scala_reflect_2_13_8", "org.scala-lang:scala-reflect:" + scala2],
        ["scala_compiler_3_1_1", "org.scala-lang:scala3-compiler_3:" + scala3],
        ["scala_interfaces_3_1_1", "org.scala-lang:scala3-interfaces:" + scala3],
        ["scala_library_3_1_1", "org.scala-lang:scala3-library_3:" + scala3],
        ["scala_sbt_bridge_3_1_1", "org.scala-lang:scala3-sbt-bridge:" + scala3],
        ["scala_tasty_core_3_1_1", "org.scala-lang:tasty-core_3:" + scala3],
        ["scala_asm_9_2_0", "org.scala-lang.modules:scala-asm:9.2.0-scala-1", "8c34d8f56614901a1f3367b15b38adc8b13107ffd8e141e004f9de1e23db8ea4"],
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
        ["scalajs_library_3_1_1_sjs", "org.scala-lang:scala3-library_sjs1_3:" + scala3],
        ["scalajs_tools_2_13", "org.scala-js:scalajs-tools_2.13:0.6.33"],
    ]
    for dep in direct_deps:
        maybe(jvm_maven_import_external, name = dep[0], artifact = dep[1], artifact_sha256 = dep[2] if len(dep) == 3 else "", server_urls = repositories)

    protobuf_tag = "3.15.8"
    rules_proto_tag = "f7a30f6f80006b591fa7c437fe5a951eb10bcbcf"
    skydoc_tag = "0.3.0"
    skylib_tag = "c6f6b5425b232baf5caecc3aae31d49d63ddec03"
    rules_deps = [
        ["bazel_skylib", "bazel-skylib-" + skylib_tag, "https://github.com/bazelbuild/bazel-skylib/archive/{}.tar.gz".format(skylib_tag), "b6cddd8206d5d2953791398b0f025a3f3f3c997872943625529e7b30eba92e78"],
        ["com_google_protobuf", "protobuf-" + protobuf_tag, "https://github.com/protocolbuffers/protobuf/archive/v{}.tar.gz".format(protobuf_tag), "0cbdc9adda01f6d2facc65a22a2be5cecefbefe5a09e5382ee8879b522c04441"],
        ["io_bazel_skydoc", "skydoc-" + skydoc_tag, "https://github.com/bazelbuild/skydoc/archive/{}.tar.gz".format(skydoc_tag)],
        ["rules_proto", "rules_proto-" + rules_proto_tag, "https://github.com/bazelbuild/rules_proto/archive/{}.tar.gz".format(rules_proto_tag), "9fc210a34f0f9e7cc31598d109b5d069ef44911a82f507d5a88716db171615a8"],
    ]
    for dep in rules_deps:
        maybe(http_archive, name = dep[0], strip_prefix = dep[1], url = dep[2], sha256 = dep[3] if len(dep) == 4 else "")

def scala_register_toolchains():
    # reserved for future use
    return ()
