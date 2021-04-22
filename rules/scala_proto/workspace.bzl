load("@rules_jvm_external//:defs.bzl", "maven_install")

scala3_version = "3.0.0-RC2"
scala2_version = "2.13"

def scala_proto_register_toolchains():
    native.register_toolchains("@rules_scala3//rules/scala_proto:scalapb_scala_proto_toolchain")

def scala_proto_artifacts():
    return [
        "com.thesamet.scalapb:compilerplugin_{}:0.11.1".format(scala3_version),
        "com.thesamet.scalapb:protoc-bridge_{}:0.9.2".format(scala2_version),
    ]

def scala_proto_repositories():
    maven_install(
        name = "annex_proto",
        artifacts = scala_proto_artifacts(),
        repositories = [
            "https://repo.maven.apache.org/maven2",
            "https://maven-central.storage-download.googleapis.com/maven2",
            "https://mirror.bazel.build/repo1.maven.org/maven2",
        ],
        fetch_sources = True,
        maven_install_json = "@rules_scala3//:annex_proto_install.json",
    )
