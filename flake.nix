{
  description = "Bazel rules_scala flake";

  inputs = {
    nixpkgs.url = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "x86_64-darwin" ] (system:
      let
        pkgs = import nixpkgs { inherit system; };
        jdk = pkgs.openjdk17_headless;
        bazel = pkgs.bazel_5;
      in
      rec {
        devShell = pkgs.callPackage ./shell.nix { inherit jdk bazel; };
      });
}
