{
  description = "Bazel rules_scala flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    java.url = "github:TawasalMessenger/jdk-flake";
    bazel.url = "/data/home/johndoe/Development/bazel-flake";
  };

  outputs = { self, nixpkgs, flake-utils, java, bazel }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "x86_64-darwin" ] (system:
      let
        pkgs = import nixpkgs { inherit system; };
        jdk = java.packages.${system}.openjdk_16;
        bazel-pre = bazel.defaultPackage.${system};
      in
      rec {
        devShell = pkgs.callPackage ./shell.nix { inherit jdk bazel-pre; };
      });
}
