{
  description = "Bazel rules_scala3 flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
    bazel.url = "github:timothyklim/bazel-flake";
    jdk.url = "github:timothyklim/jdk-flake";
  };

  outputs = { self, nixpkgs, flake-utils, bazel, jdk }:
    with flake-utils.lib; with system; eachSystem [ aarch64-darwin aarch64-linux x86_64-linux ] (system:
      let
        jdk_24 = jdk.packages.${system}.jdk_24;
        pkgs = import nixpkgs {
          inherit system;

          overlays = [
            (self: super: with super; rec {
              jdk = jdk_24;
            })
          ];
        };
      in
      rec {
        devShell = pkgs.callPackage ./shell.nix {
          bazel = bazel.packages.${system}.default;
        };
        formatter = nixpkgs.legacyPackages.${system}.nixpkgs-fmt;
      });
}
