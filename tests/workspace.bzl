load("@rules_jvm_external//:defs.bzl", "maven_install")

scala3_version = "3.0.0-RC1"

def test_artifacts():
    return [
        "com.google.protobuf:protobuf-java:3.15.7",
        "com.thesamet.scalapb:lenses_{}:0.11.0".format(scala3_version),
        "com.thesamet.scalapb:scalapb-runtime_{}:0.11.0".format(scala3_version),
        "org.scala-lang.modules:scala-xml_{}:2.0.0-RC1".format(scala3_version),
        "org.scala-sbt:compiler-interface:1.5.0-M5",
        "org.scalacheck:scalacheck_{}:1.15.3".format(scala3_version),
        "org.scalameta:munit_{}:0.7.23".format(scala3_version),
        "org.scalameta:munit-scalacheck_{}:0.7.23".format(scala3_version),
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
