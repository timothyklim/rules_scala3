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
    scala3 = "3.0.0-RC3"
    scala2_version = "2.13"

    return [
        "com.github.scopt:scopt_{}:4.0.1".format(scala3),
        "org.jacoco:org.jacoco.core:0.8.7",
        "org.scala-lang.modules:scala-xml_{}:2.0.0-RC1".format(scala3),
        "org.scala-sbt:test-interface:1.0",
        "org.scala-sbt:util-interface:{}".format(sbt_version),
        "org.scala-sbt:util-logging_{}:{}".format(scala2_version, sbt_version),
        "org.scala-sbt:zinc_{}:{}".format(scala2_version, zinc_version),
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

    scala2 = "2.13.6-bin-107c727"
    scala3 = "3.0.0-RC3"

    direct_deps = [
        # ["scala_compiler_2_13_6", "org.scala-lang:scala-compiler:" + scala2, "61a1d7765b716e29bddcc05d5c8bcb8caf68745016b50b4d00f4a895808044f6"],
        # ["scala_library_2_13_6", "org.scala-lang:scala-library:" + scala2, "7e4ea50c2abdd7e7c9d58df823354b765c5efb797ae9550a959b7f47e6ad18c2"],
        # ["scala_reflect_2_13_6", "org.scala-lang:scala-reflect:" + scala2, "53f5c2de8beab1093f458866dbbc86a1ce8e570f47768b037d09a054347e0096"],
        ["scala_compiler_3_0_0", "org.scala-lang:scala3-compiler_3.0.0-RC3:" + scala3, "a94b6b501c4ad76095ca76d94c4188fc5186a64a2921d7190a28a5d21c4250b2"],
        ["scala_interfaces_3_0_0", "org.scala-lang:scala3-interfaces:" + scala3, "34ff12ec189cf63f7f3e6abee7c279ebbcdc4df3bfcd4973776c7e6f444aa198"],
        ["scala_library_3_0_0", "org.scala-lang:scala3-library_3.0.0-RC3:" + scala3, "c19a214fa9205306671ea0e1fd3fa2598eac0c3fcce76366adb4d6706374a7b5"],
        ["scala_sbt_bridge_3_0_0", "org.scala-lang:scala3-sbt-bridge:" + scala3, "f151f0e150c51aa60a4b775f8b1d46de739d42b234c7e8797ed793256718038b"],
        ["scala_tasty_core_3_0_0", "org.scala-lang:tasty-core_3.0.0-RC3:" + scala3, "fac6282be86a4c6b8b36869791e8adc978c41bfcc64f8f46380924815fb19399"],
        ["scala_asm_9_1_0", "org.scala-lang.modules:scala-asm:9.1.0-scala-1", "b85af6cbbd6075c4960177c2c3aa03d53b5221fa58b0bc74a31b72f25595e39f"],
    ]
    for dep in direct_deps:
        if len(dep) == 3:
            maybe(jvm_maven_import_external, name = dep[0], artifact = dep[1], artifact_sha256 = dep[2], server_urls = repositories)
        elif len(dep) == 2:
            maybe(jvm_maven_import_external, name = dep[0], artifact = dep[1], server_urls = repositories)
        else:
            fail("Unknown dep structure: {}".format(dep))

    snapshot = "2.13.6-bin-937b234-SNAPSHOT"
    full_version = "2.13.6-bin-937b234-20210507.172551-1"
    snapshot_repo = "https://scala-ci.typesafe.com/artifactory/scala-pr-validation-snapshots/org/scala-lang"
    snapshot_deps = [
        ["scala_compiler_2_13_6", "{}/scala-compiler/{}/scala-compiler-{}.jar".format(snapshot_repo, snapshot, full_version), "b40177eed0f7474f04e070da772e89227e3eccb0c302ba714553dc607ff5d09f"],
        ["scala_library_2_13_6", "{}/scala-library/{}/scala-library-{}.jar".format(snapshot_repo, snapshot, full_version), "5bc0d060569c0a91de88bc0be2869ca79c56c4bf6334a026b6185dd871ca754e"],
        ["scala_reflect_2_13_6", "{}/scala-reflect/{}/scala-reflect-{}.jar".format(snapshot_repo, snapshot, full_version), "65764e8e83fba9770c40abc4e6c5314271ff91494a3a98c189a95f397cfae1e1"],
    ]
    for dep in snapshot_deps:
        if len(dep) == 3:
            maybe(java_import_external, name = dep[0], jar_urls = [dep[1]], jar_sha256 = dep[2])
        elif len(dep) == 2:
            maybe(java_import_external, name = dep[0], jar_urls = [dep[1]])
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
