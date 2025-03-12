workspace(name = "rules_scala3")

# nixpkgs_local_repository(
#     name = "nixpkgs",
#     nix_file = "//:nixpkgs.nix",
#     nix_file_deps = [
#         "//:flake.lock",
#         "//:flake.nix",
#     ],
# )

# nixpkgs_cc_configure(repository = "@nixpkgs")

# ---

load("//rules/scala:workspace.bzl", "scala_register_toolchains", "scala_repositories")

scala_repositories()

load("//rules/scala:init.bzl", "rules_scala3_init")

rules_scala3_init()

scala_register_toolchains(default_compiler = "bootstrap")

# load("//mezel_compatibility:repositories.bzl", "mezel_compatibility_repository")

# mezel_compatibility_repository(
#     name = "mezel",
#     mezel_version = "216327ab2fc6d5866f13ace1bf75c9d1abdcd8a6",
#     sha256 = "dbdb144fc943670dc1b715629f939d8f5010ae1b2ab889b3620866ce19cda1df",
# )

# load("@mezel//rules:load_mezel.bzl", "load_mezel")

# load_mezel()
