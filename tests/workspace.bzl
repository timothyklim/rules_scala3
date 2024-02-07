load("@rules_jvm_external//:defs.bzl", "maven_install")

scalapb_version = "0.11.15"
munit_version = "1.0.0-M11"

def test_artifacts():
    return [
        "com.thesamet.scalapb:lenses_3:" + scalapb_version,
        "com.thesamet.scalapb:scalapb-runtime_3:" + scalapb_version,
        "com.thesamet.scalapb:scalapb-runtime-grpc_3:" + scalapb_version,
        "com.thesamet.scalapb.grpcweb:scalapb-grpcweb_sjs1_3:0.7.0",
        "io.grpc:grpc-netty:1.57.0",
        "org.scala-js:scalajs-dom_sjs1_3:2.8.0",
        "org.scala-lang.modules:scala-xml_3:2.2.0",
        "org.scala-sbt:compiler-interface:2.0.0-alpha10",
        "org.scalacheck:scalacheck_3:1.17.0",
        "org.scalameta:munit_3:" + munit_version,
        "org.scalameta:munit-scalacheck_3:" + munit_version,
    ]

def test_dependencies():
    maven_install(
        name = "annex_test",
        artifacts = test_artifacts(),
        repositories = [
            "https://repo.maven.apache.org/maven2",
            "https://maven-central.storage-download.googleapis.com/maven2",
            "https://mirror.bazel.build/repo1.maven.org/maven2",
        ],
        fetch_sources = True,
        maven_install_json = "@rules_scala3_test//:annex_test_install.json",
    )
