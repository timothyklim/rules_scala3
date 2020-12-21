load("@rules_jvm_external//:defs.bzl", "maven_install")

def test_artifacts():
    return [
        "org.scala-sbt:compiler-interface:1.4.4",
        "org.scala-lang.modules:scala-xml_2.13:1.3.0",
        "org.scalacheck:scalacheck_2.13:1.15.0",
        "org.specs2:specs2-matcher_2.13:4.10.5",
        "org.specs2:specs2-core_2.13:4.10.5",
        "com.thesamet.scalapb:scalapb-runtime_2.13:0.10.8",
        "com.thesamet.scalapb:lenses_2.13:0.10.8",
        "com.google.protobuf:protobuf-java:3.9.0",
        "org.scalatest:scalatest_2.13:3.1.4",
        "org.scalactic:scalactic_2.13:3.1.4",
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
        maven_install_json = "@rules_scala_annex_test//:annex_test_install.json",
    )
