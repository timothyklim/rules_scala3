load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:jvm.bzl", "jvm_maven_import_external")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("@rules_jvm_external//:defs.bzl", "maven_install")

# compatibility
load("//scala3:repositories.bzl", _scala_register_toolchains = "scala3_register_toolchains")

scala_register_toolchains = _scala_register_toolchains

# ---

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

sbt_version = "2.0.0-M3"

def scala_repositories():
    maven_install(
        artifacts = [
            "io.get-coursier:coursier_2.13:2.1.24",
            "org.scala-sbt:librarymanagement-core_3:2.0.0-M3",
            "org.scala-sbt:librarymanagement-coursier_3:2.0.0-M3",
        ],
        repositories = ["https://repo1.maven.org/maven2"],
    )

    http_archive(
        name = "compiler_bridge_2_13",
        build_file_content = _SRC_FILEGROUP_BUILD_FILE_CONTENT,
        integrity = "sha256-iF4q+5szu2DCxWRaA0ZJ1ckDg/EFX6Jba0DGsfV0Tog=",
        url = "https://repo.maven.apache.org/maven2/org/scala-sbt/compiler-bridge_2.13/{v}/compiler-bridge_2.13-{v}-sources.jar".format(v = sbt_version),
    )

    scala2 = "2.13.16"
    scala3 = "3.7.1"
    scalajs = "1.19.0"

    direct_deps = [
        ["org_scala_sbt_compiler_interface", "org.scala-sbt:compiler-interface:" + sbt_version],
        ["scala_asm", "org.scala-lang.modules:scala-asm:9.7.1-scala-1"],
        ["scala_compiler_2_13", "org.scala-lang:scala-compiler:" + scala2],
        ["scala_library_2_13", "org.scala-lang:scala-library:" + scala2],
        ["scala_reflect_2_13", "org.scala-lang:scala-reflect:" + scala2],
        ["scala_tasty_core_3", "org.scala-lang:tasty-core_3:" + scala3],
        ["scala3_compiler", "org.scala-lang:scala3-compiler_3:" + scala3],
        ["scala3_interfaces", "org.scala-lang:scala3-interfaces:" + scala3],
        ["scala3_library_sjs1_3", "org.scala-lang:scala3-library_sjs1_3:" + scala3],
        ["scala3_library", "org.scala-lang:scala3-library_3:" + scala3],
        ["scala3_sbt_bridge", "org.scala-lang:scala3-sbt-bridge:" + scala3],
        ["scalajs_compiler_2_13", "org.scala-js:scalajs-compiler_2.13.15:" + scalajs],
        ["scalajs_env_nodejs_2_13", "org.scala-js:scalajs-env-nodejs_2.13:1.2.1"],
        ["scalajs_ir_2_13", "org.scala-js:scalajs-ir_2.13:" + scalajs],
        ["scalajs_js_envs_2_13", "org.scala-js:scalajs-js-envs_2.13:1.2.1"],
        ["scalajs_library_2_13", "org.scala-js:scalajs-library_2.13:" + scalajs],
        ["scalajs_linker_2_13", "org.scala-js:scalajs-linker_2.13:" + scalajs],
        ["scalajs_linker_interface_2_13", "org.scala-js:scalajs-linker-interface_2.13:" + scalajs],
        ["scalajs_logging_2_13", "org.scala-js:scalajs-logging_2.13:1.1.1"],
        ["scalajs_parallel_collections", "org.scala-lang.modules:scala-parallel-collections_2.13:1.0.4"],
        ["scalajs_sbt_test_adapter_2_13", "org.scala-js:scalajs-sbt-test-adapter_2.13:" + scalajs],
        ["scalajs_test_bridge_2_13", "org.scala-js:scalajs-test-bridge_2.13:" + scalajs],
        ["scalajs_test_interface_2_13", "org.scala-js:scalajs-test-interface_2.13:" + scalajs],
        ["scalajs_tools_2_13", "org.scala-js:scalajs-tools_2.13:0.6.33"],
    ]
    for dep in direct_deps:
        maybe(jvm_maven_import_external, name = dep[0], artifact = dep[1], artifact_sha256 = dep[2] if len(dep) == 3 else "", server_urls = repositories)
