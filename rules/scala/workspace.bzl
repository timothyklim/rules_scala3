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

scala2_version = "2.13.4"
zinc_version = "1.4.3"

def scala_artifacts():
    return [
        "org.scala-lang:scala-compiler:" + scala2_version,
        "org.scala-lang:scala-library:" + scala2_version,
        "org.scala-lang:scala-reflect:" + scala2_version,
        "net.sourceforge.argparse4j:argparse4j:0.8.1",
        "org.jacoco:org.jacoco.core:0.7.5.201505241946",
        "com.lihaoyi:sourcecode_2.13:0.2.1,",
        "org.scala-sbt:test-interface:1.0",
        "org.scala-sbt:util-interface:" + zinc_version,
        "org.scala-sbt:util-logging_2.13:" + zinc_version,
        "org.scala-sbt:compiler-interface:" + zinc_version,
        "org.scala-sbt:zinc_2.13:" + zinc_version,
        "org.scala-sbt:zinc-persist_2.13:" + zinc_version,
        "org.scala-sbt:zinc-core_2.13:" + zinc_version,
        "org.scala-sbt:zinc-apiinfo_2.13:" + zinc_version,
        "org.scala-sbt:zinc-classpath_2.13:" + zinc_version,
    ]

def scala_repositories(java_launcher_version = "0.29.1"):
    maven_install(
        name = "annex",
        artifacts = scala_artifacts(),
        repositories = [
            "https://repo.maven.apache.org/maven2",
            "https://maven-central.storage-download.googleapis.com/maven2",
            "https://mirror.bazel.build/repo1.maven.org/maven2",
        ],
        fetch_sources = True,
        maven_install_json = "@rules_scala_annex//:annex_install.json",
    )

    java_stub_template_url = (
        "raw.githubusercontent.com/bazelbuild/bazel/" +
        java_launcher_version +
        "/src/main/java/com/google/devtools/build/lib/bazel/rules/java/" +
        "java_stub_template.txt"
    )

    http_file(
        name = "anx_java_stub_template",
        sha256 = "e6531a6539ec1e38fec5e20523ff4bfc883e1cc0209eb658fe82eb918eb49657",
        urls = [
            "https://mirror.bazel.build/%s" % java_stub_template_url,
            "https://%s" % java_stub_template_url,
        ],
    )

    http_archive(
        name = "compiler_bridge_2_13",
        build_file_content = _SRC_FILEGROUP_BUILD_FILE_CONTENT,
        sha256 = "dbc8ac87c67086b69cc2320b41d241f53bd5bb36bb722778f5d7b6b75c33a2ee",
        url = "https://repo.maven.apache.org/maven2/org/scala-sbt/compiler-bridge_2.13/" + zinc_version +"/compiler-bridge_2.13-" + zinc_version +"-sources.jar",
    )

    http_archive(
        name = "compiler_bridge_3_0",
        build_file_content = _SRC_FILEGROUP_BUILD_FILE_CONTENT,
        sha256 = "bf19ab10028936662c8bb502cb22c4cb7f4184a4903ade156f13fa7102b600df",
        url = "https://repo1.maven.org/maven2/org/scala-lang/scala3-sbt-bridge/3.0.0-M2/scala3-sbt-bridge-3.0.0-M2-sources.jar",
    )

def scala_register_toolchains():
    # reserved for future use
    return ()
