{
  description = "Bazel rules_scala flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
    flake-utils.url = "github:numtide/flake-utils";
    bazel.url = "github:timothyklim/bazel-flake";
    java.url = "github:timothyklim/jdk-flake";
  };

  outputs = { self, nixpkgs, flake-utils, bazel, java }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "x86_64-darwin" ] (system:
      let
        pkgs = import nixpkgs { inherit system; };
        jdk = java.packages.${system}.openjdk_19;
        bazel-pre = bazel.packages.${system}.default;
      in
      rec {
        devShell = pkgs.callPackage ./shell.nix { inherit jdk bazel-pre; };
      });
}
