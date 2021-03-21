load("@rules_jvm_external//:defs.bzl", "maven_install")

def test_artifacts():
    return [
        "com.google.protobuf:protobuf-java:3.15.6",
        "com.thesamet.scalapb:lenses_3.0.0-RC1:0.11.0",
        "com.thesamet.scalapb:scalapb-runtime_3.0.0-RC1:0.11.0",
        "org.scala-lang.modules:scala-xml_3.0.0-RC1:2.0.0-M5",
        "org.scala-sbt:compiler-interface:1.5.0-M4",
        "org.scalacheck:scalacheck_3.0.0-RC1:1.15.3",
        "org.scalameta:munit_3.0.0-RC1:0.7.22",
        "org.scalameta:munit-scalacheck_3.0.0-RC1:0.7.22",
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
        maven_install_json = "@rules_scala_test//:annex_test_install.json",
    )
