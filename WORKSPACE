workspace(name = "rules_scala3")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

rules_jvm_external_tag = "4.5"

http_archive(
    name = "rules_jvm_external",
    sha256 = "6e9f2b94ecb6aa7e7ec4a0fbf882b226ff5257581163e88bf70ae521555ad271",
    strip_prefix = "rules_jvm_external-{}".format(rules_jvm_external_tag),
    url = "https://github.com/bazelbuild/rules_jvm_external/archive/{}.tar.gz".format(rules_jvm_external_tag),
)

load("@rules_jvm_external//:defs.bzl", "maven_install")

maven_install(
    name = "deps",
    artifacts = [
        "com.github.scopt:scopt_3:4.1.0",
        "org.scala-sbt:librarymanagement-core_3:2.0.0-alpha12",
        "org.scala-sbt:librarymanagement-coursier_3:2.0.0-alpha6",
    ],
    fetch_sources = True,
    maven_install_json = "//:deps_install.json",
    repositories = [
        "https://repo1.maven.org/maven2",
        "https://repo.maven.apache.org/maven2",
        "https://maven-central.storage-download.googleapis.com/maven2",
        "https://mirror.bazel.build/repo1.maven.org/maven2",
        "https://scala-ci.typesafe.com/artifactory/scala-integration/",
    ],
)

load("@deps//:defs.bzl", "pinned_maven_install")

pinned_maven_install()

# ---

load("//rules/scala:workspace.bzl", "scala_register_toolchains", "scala_repositories")

scala_repositories()

load("//rules/scala:init.bzl", "rules_scala3_init")

rules_scala3_init()

load("@annex//:defs.bzl", annex_pinned_maven_install = "pinned_maven_install")

annex_pinned_maven_install()

scala_register_toolchains(default_compiler = "bootstrap")

load("//3rdparty:workspace.bzl", "maven_dependencies")

maven_dependencies()

load("//mezel_compatibility:repositories.bzl", "mezel_compatibility_repository")

mezel_compatibility_repository(
    name = "mezel",
    mezel_version = "216327ab2fc6d5866f13ace1bf75c9d1abdcd8a6",
    sha256 = "dbdb144fc943670dc1b715629f939d8f5010ae1b2ab889b3620866ce19cda1df",
)

load("@mezel//rules:load_mezel.bzl", "load_mezel")

load_mezel()

load("//rules/scalafmt:workspace.bzl", "scalafmt_default_config", "scalafmt_repositories")

scalafmt_repositories()

load("@annex_scalafmt//:defs.bzl", annex_scalafmt_pinned_maven_install = "pinned_maven_install")

annex_scalafmt_pinned_maven_install()

scalafmt_default_config(".scalafmt.conf")

load(
    "//rules/scala_proto:workspace.bzl",
    "scala_proto_register_toolchains",
    "scala_proto_repositories",
)

scala_proto_repositories()

scala_proto_register_toolchains()

load("@annex_proto//:defs.bzl", annex_proto_pinned_maven_install = "pinned_maven_install")

annex_proto_pinned_maven_install()
