{
  description = "Bazel rules_scala flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    java.url = "github:TawasalMessenger/jdk-flake";
    bazel.url = "github:timothyklim/bazel-flake";
  };

  outputs = { self, nixpkgs, flake-utils, java, bazel }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "x86_64-darwin" ] (system:
      let
        pkgs = import nixpkgs { inherit system; };
        jdk =
          if pkgs.stdenv.isDarwin
          then pkgs.jdk16_headless
          else java.packages.${system}.openjdk_16;
        bazel-pre = bazel.defaultPackage.${system};
      in
      rec {
        devShell = pkgs.callPackage ./shell.nix { inherit jdk bazel-pre; };
      });
}
