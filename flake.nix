{
  description = "Bazel rules_scala flake";

  inputs = {
    nixpkgs.url = "nixpkgs/release-23.05";
    flake-utils.url = "github:numtide/flake-utils";
    bazel.url = "github:timothyklim/bazel-flake";
    java.url = "github:timothyklim/jdk-flake";
  };

  outputs = { self, nixpkgs, flake-utils, bazel, java }:
    with flake-utils.lib; eachSystem [
      system.aarch64-darwin
      system.aarch64-linux
      system.x86_64-darwin
      system.x86_64-linux
    ]
      (system:
        let
          pkgs = import nixpkgs { inherit system; };
          jdk = java.packages.${system}.openjdk_21;
          bazel-pre = bazel.packages.${system}.default;
        in
        rec {
          devShell = pkgs.callPackage ./shell.nix { inherit jdk bazel-pre; };
          formatter = nixpkgs.legacyPackages.${system}.nixpkgs-fmt;
        });
}
