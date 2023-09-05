{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    bazel.url = "github:timothyklim/bazel-flake";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, bazel }:
    flake-utils.lib.eachDefaultSystem (system:
      with nixpkgs.legacyPackages.${system};
      {
        devShells.default = mkShell {
          shellHook = "idea-community & exit";
          packages = [
            bazel.packages.${system}.default
            jetbrains.idea-community
            bazel-buildtools
            gcc
            zlib
          ];
        };
      });
}
