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
    artifacts = [
        "org.scala-sbt:librarymanagement-core_3:2.0.0-M2",
        "org.scala-sbt:librarymanagement-coursier_3:2.0.0-alpha8",
    ],
    repositories = [
        "https://repo1.maven.org/maven2",
    ],
)

rules_cc_version = "0.0.9"

http_archive(
    name = "rules_cc",
    sha256 = "2037875b9a4456dce4a79d112a8ae885bbc4aad968e6587dca6e64f3a0900cdf",
    strip_prefix = "rules_cc-" + rules_cc_version,
    url = "https://github.com/bazelbuild/rules_cc/archive/{}.tar.gz".format(rules_cc_version),
)

rules_nixpkgs_tag = "705ee3b26cf49e990cddbbe6f60510fa46d50904"

http_archive(
    name = "io_tweag_rules_nixpkgs",
    sha256 = "f2c927815c18c088f02ff81caf9903f9c0b2596ac6e6bd40534bc299af9dc0d7",
    strip_prefix = "rules_nixpkgs-" + rules_nixpkgs_tag,
    url = "https://github.com/tweag/rules_nixpkgs/archive/{}.tar.gz".format(rules_nixpkgs_tag),
)

load("@io_tweag_rules_nixpkgs//nixpkgs:repositories.bzl", "rules_nixpkgs_dependencies")

rules_nixpkgs_dependencies()

load("@io_tweag_rules_nixpkgs//nixpkgs:nixpkgs.bzl", "nixpkgs_cc_configure", "nixpkgs_local_repository")

nixpkgs_local_repository(
    name = "nixpkgs",
    nix_file = "//:nixpkgs.nix",
    nix_file_deps = [
        "//:flake.lock",
        "//:flake.nix",
    ],
)

nixpkgs_cc_configure(repository = "@nixpkgs")

# ---

load("//rules/scala:workspace.bzl", "scala_register_toolchains", "scala_repositories")

scala_repositories()

load("//rules/scala:init.bzl", "rules_scala3_init")

rules_scala3_init()

scala_register_toolchains(default_compiler = "bootstrap")

load("//mezel_compatibility:repositories.bzl", "mezel_compatibility_repository")

mezel_compatibility_repository(
    name = "mezel",
    mezel_version = "216327ab2fc6d5866f13ace1bf75c9d1abdcd8a6",
    sha256 = "dbdb144fc943670dc1b715629f939d8f5010ae1b2ab889b3620866ce19cda1df",
)

load("@mezel//rules:load_mezel.bzl", "load_mezel")

load_mezel()
