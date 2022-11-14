load("@rules_jvm_external//:defs.bzl", "maven_install")

def scala_proto_register_toolchains():
    native.register_toolchains("@rules_scala3//rules/scala_proto:scalapb_scala_proto_toolchain")

def scala_proto_artifacts():
    return [
        "com.thesamet.scalapb:compilerplugin_3:0.11.11",
        "com.thesamet.scalapb:protoc-bridge_2.13:0.9.6",
        "com.thesamet.scalapb.grpcweb:scalapb-grpcweb-code-gen_3:0.6.4",
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
