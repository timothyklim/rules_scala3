{
  description = "Bazel rules_scala3 flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    flake-utils.url = "github:numtide/flake-utils";
    bazel.url = "github:timothyklim/bazel-flake";
  };

  outputs = { self, nixpkgs, flake-utils, bazel }:
    with flake-utils.lib; with system; eachSystem [ aarch64-darwin aarch64-linux x86_64-linux ] (system:
      let
        pkgs = import nixpkgs {
          inherit system;

          overlays = [
            (self: super: with super; rec {
              jdk = super.openjdk21_headless;
            })
          ];
        };
      in
      rec {
        devShell = pkgs.callPackage ./shell.nix {
          bazel = pkgs.bazel_7;
          # bazel = bazel.packages.${system}.default;
        };
        formatter = nixpkgs.legacyPackages.${system}.nixpkgs-fmt;
      });
}
