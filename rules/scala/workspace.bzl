load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")
load("@bazel_tools//tools/build_defs/repo:jvm.bzl", "jvm_maven_import_external")
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

scala3_version = "3.0.0-RC1"
sbt_version = "1.5.0-RC2"
zinc_version = "1.5.0-M5"

def scala_artifacts():
    return [
        "com.github.scopt:scopt_{}:4.0.1".format(scala3_version),
        "net.sourceforge.argparse4j:argparse4j:0.8.1",
        "org.jacoco:org.jacoco.core:0.8.6",
        "org.scala-lang.modules:scala-xml_{}:2.0.0-M5".format(scala3_version),
        "org.scala-sbt:test-interface:1.0",
        "org.scala-sbt:util-interface:" + sbt_version,
        "org.scala-sbt:util-logging_2.13:" + sbt_version,
        "org.scala-sbt:zinc_2.13:" + zinc_version,
    ]

def scala_repositories(java_launcher_version = "4.0.0"):
    maven_install(
        name = "annex",
        artifacts = scala_artifacts(),
        repositories = [
            "https://repo.maven.apache.org/maven2",
            "https://maven-central.storage-download.googleapis.com/maven2",
            "https://mirror.bazel.build/repo1.maven.org/maven2",
        ],
        fetch_sources = True,
        maven_install_json = "@rules_scala//:annex_install.json",
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
        sha256 = "37ffa89c657593dd95de4302eeb1cd59c3411eb6d6b4b6296c7a421ee32d31c6",
        url = "https://repo.maven.apache.org/maven2/org/scala-sbt/compiler-bridge_2.13/{}/compiler-bridge_2.13-{}-sources.jar".format(zinc_version, zinc_version),
    )

def scala_register_toolchains():
    # reserved for future use
    return ()
