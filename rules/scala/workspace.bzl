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
]

sbt_version = "1.5.5"
zinc_version = "1.5.7"

def scala_artifacts():
    return [
        "com.github.scopt:scopt_3:4.0.1",
        "org.jacoco:org.jacoco.core:0.8.7",
        "org.scala-lang.modules:scala-xml_3:2.0.0",
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
        sha256 = "d2663d3ec4de76801d16e4d032223bdaf0533a74b5c3a57897eeb41889062c7e",
        url = "https://repo.maven.apache.org/maven2/org/scala-sbt/compiler-bridge_2.13/{}/compiler-bridge_2.13-{}-sources.jar".format(zinc_version, zinc_version),
    )

    scala2 = "2.13.6"
    scala3 = "3.0.1"
    scalajs = "1.6.0"

    direct_deps = [
        ["scala_compiler_2_13_6", "org.scala-lang:scala-compiler:" + scala2, "310d263d622a3d016913e94ee00b119d270573a5ceaa6b21312d69637fd9eec1"],
        ["scala_library_2_13_6", "org.scala-lang:scala-library:" + scala2, "f19ed732e150d3537794fd3fe42ee18470a3f707efd499ecd05a99e727ff6c8a"],
        ["scala_reflect_2_13_6", "org.scala-lang:scala-reflect:" + scala2, "f713593809b387c60935bb9a940dfcea53bd0dbf8fdc8d10739a2896f8ac56fa"],
        ["scala_compiler_3_0_1", "org.scala-lang:scala3-compiler_3:" + scala3, "44ce0ee11bfc1e6784c19906512c1e573d8be0b05fed96f5f6027f8a884c1c8d"],
        ["scala_interfaces_3_0_1", "org.scala-lang:scala3-interfaces:" + scala3, "2c35ec130fbe9cbfe0f7c24a010f596045a5cdadda332249706d31d647db4816"],
        ["scala_library_3_0_1", "org.scala-lang:scala3-library_3:" + scala3, "43584226adb12326b8a81287f4c607993b3316764e63034c7748576ccb11bf8e"],
        ["scala_sbt_bridge_3_0_1", "org.scala-lang:scala3-sbt-bridge:" + scala3, "3cd6de55d118d509736da98e4de12ce8d9b2fc2c43dae53bdb2e5ff7b111087a"],
        ["scala_tasty_core_3_0_1", "org.scala-lang:tasty-core_3:" + scala3, "3fcf45b6f5f1a390e9d2ca519f4877be27c4b2caf8c0f78d68d95a303f7b6fa0"],
        ["scala_asm_9_1_0", "org.scala-lang.modules:scala-asm:9.1.0-scala-1", "b85af6cbbd6075c4960177c2c3aa03d53b5221fa58b0bc74a31b72f25595e39f"],
        ["scalajs_compiler_2_13", "org.scala-js:scalajs-compiler_2.13:" + scalajs],
        ["scalajs_env_nodejs_2_13", "org.scala-js:scalajs-env-nodejs_2.13:1.1.1", ""],
        ["scalajs_ir_2_13", "org.scala-js:scalajs-ir_2.13:" + scalajs],
        ["scalajs_js_envs_2_13", "org.scala-js:scalajs-js-envs_2.13:1.1.1", ""],
        ["scalajs_library_2_13", "org.scala-js:scalajs-library_2.13:" + scalajs, ""],
        ["scalajs_linker_2_13", "org.scala-js:scalajs-linker_2.13:" + scalajs, ""],
        ["scalajs_linker_interface_2_13", "org.scala-js:scalajs-linker-interface_2.13:" + scalajs, ""],
        ["scalajs_logging_2_13", "org.scala-js:scalajs-logging_2.13:1.1.1", ""],
        ["scalajs_sbt_test_adapter_2_13", "org.scala-js:scalajs-sbt-test-adapter_2.13:" + scalajs, ""],
        ["scalajs_test_bridge_2_13", "org.scala-js:scalajs-test-bridge_2.13:" + scalajs, ""],
        ["scalajs_test_interface_2_13", "org.scala-js:scalajs-test-interface_2.13:" + scalajs, ""],
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

    bazel_commit = "4ddb5955c2e5e161f68584678844900152353b0a"
    http_archive(
        name = "bazel",
        sha256 = "7016824922c3b344c72714c489acfaa1199c7014bdccc57dd3de954651a9f1d7",
        strip_prefix = "bazel-{}".format(bazel_commit),
        url = "https://github.com/bazelbuild/bazel/archive/{}.tar.gz".format(bazel_commit),
    )

def scala_register_toolchains():
    # reserved for future use
    return ()
