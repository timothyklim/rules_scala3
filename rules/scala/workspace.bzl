load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")
load("@bazel_tools//tools/build_defs/repo:java.bzl", "java_import_external")
load("@bazel_tools//tools/build_defs/repo:jvm.bzl", "jvm_maven_import_external")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("@rules_jvm_external//:defs.bzl", "maven_install")
load("@rules_scala3//rules:scala.bzl", "configure_bootstrap_scala", "configure_zinc_scala", "scala_library")

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
    "https://scala-ci.typesafe.com/artifactory/scala-integration/",
    "https://repo.maven.apache.org/maven2",
    "https://maven-central.storage-download.googleapis.com/maven2",
    "https://mirror.bazel.build/repo1.maven.org/maven2",
]

sbt_version = "1.5.2"
zinc_version = "1.5.3"

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

# TODO: replace by https://github.com/bazelbuild/bazel/commit/8ace6dbfcb6aae2627ed623001c6eb1cfd781832
# @bazel_tools//tools:java/com/google/devtools/build/lib/bazel/rules/java/java_stub_template.txt
def scala_repositories(java_launcher_version = "4.0.0"):
    maven_install(
        name = "annex",
        artifacts = scala_artifacts(),
        repositories = repositories,
        fetch_sources = True,
        maven_install_json = "@rules_scala3//:annex_install.json",
    )

    http_file(
        name = "anx_java_stub_template",
        sha256 = "3bead51d19b11eff5d20840022d106f5af93811731f009f88bfeb48990d6b492",
        urls = [
            "https://raw.githubusercontent.com/bazelbuild/bazel/{}/src/main/java/com/google/devtools/build/lib/bazel/rules/java/java_stub_template.txt".format(java_launcher_version),
        ],
    )

    http_archive(
        name = "compiler_bridge_2_13",
        build_file_content = _SRC_FILEGROUP_BUILD_FILE_CONTENT,
        sha256 = "ef653fc52ff2451c4fa97bda6f4c7c00d55d0e6d3ae5329f6d93f0b52922362d",
        url = "https://repo.maven.apache.org/maven2/org/scala-sbt/compiler-bridge_2.13/{}/compiler-bridge_2.13-{}-sources.jar".format(zinc_version, zinc_version),
    )

    scala2 = "2.13.6-bin-9468b9a"
    scala3 = "3.0.0"

    direct_deps = [
        ["scala_compiler_2_13_6", "org.scala-lang:scala-compiler:" + scala2, "7d216a19d68b8921024874666b227de3d885fd0825f2e1c756ea8836882c18ed"],
        ["scala_library_2_13_6", "org.scala-lang:scala-library:" + scala2, "91eff8d734f69165d4ec955537634321e1f9b74eebb0991859bc03fcf3ea4275"],
        ["scala_reflect_2_13_6", "org.scala-lang:scala-reflect:" + scala2, "3a64322b5d3bb8ac46c8f43ff43343b9d1c9809e00d2a014518a5f6c78669a2e"],
        ["scala_compiler_3_0_0", "org.scala-lang:scala3-compiler_3:" + scala3, "47d01cd513a42f7e610460973e60fcf49dde9d10085986e42733c9513a05d188"],
        ["scala_interfaces_3_0_0", "org.scala-lang:scala3-interfaces:" + scala3, "7367b9837c22424e05f906c85deb0efa5330d9370dfcdc02e35fb033b8993b68"],
        ["scala_library_3_0_0", "org.scala-lang:scala3-library_3:" + scala3, "1af055a657bebd47d82e8825bb58a9c7602bee0e6f041ddf38a177e9fdb5626b"],
        ["scala_sbt_bridge_3_0_0", "org.scala-lang:scala3-sbt-bridge:" + scala3, "ae1e940adb52e72f386e766d0e65062ed4f9dbe8106d0b3b21ebcab189aaa93c"],
        ["scala_tasty_core_3_0_0", "org.scala-lang:tasty-core_3:" + scala3, "81a639ba521e0cd1ca9b23a2626387e969e53c152ee9a2f2b75f09580c2a66ef"],
        ["scala_asm_9_1_0", "org.scala-lang.modules:scala-asm:9.1.0-scala-1", "b85af6cbbd6075c4960177c2c3aa03d53b5221fa58b0bc74a31b72f25595e39f"],
    ]
    for dep in direct_deps:
        if len(dep) == 3:
            maybe(jvm_maven_import_external, name = dep[0], artifact = dep[1], artifact_sha256 = dep[2], server_urls = repositories)
        elif len(dep) == 2:
            maybe(jvm_maven_import_external, name = dep[0], artifact = dep[1], server_urls = repositories)
        else:
            fail("Unknown dep structure: {}".format(dep))

    protobuf_tag = "3.17.0"
    rules_deps = [
        ["com_google_protobuf", "protobuf-{}".format(protobuf_tag), "https://github.com/protocolbuffers/protobuf/archive/v{}.tar.gz".format(protobuf_tag), "eaba1dd133ac5167e8b08bc3268b2d33c6e9f2dcb14ec0f97f3d3eed9b395863"],
    ]
    for dep in rules_deps:
        if len(dep) == 4:
            maybe(http_archive, name = dep[0], strip_prefix = dep[1], url = dep[2], sha256 = dep[3])
        else:
            fail("Unknown dep structure: {}".format(dep))

    bazel_commit = "4.0.0"
    http_archive(
        name = "bazel",
        sha256 = "2b9999d06466815ab1f2eb9c6fc6fceb6061efc715b4086fa99eac041976fb4f",
        strip_prefix = "bazel-{}".format(bazel_commit),
        url = "https://github.com/bazelbuild/bazel/archive/{}.tar.gz".format(bazel_commit),
    )

def scala_register_toolchains():
    # reserved for future use
    return ()
