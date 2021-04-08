{
  description = "Bazel rules_scala flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    java.url = "github:TawasalMessenger/jdk-flake";
  };

  outputs = { self, nixpkgs, flake-compat, java }:
    let
      sources = with builtins; (fromJSON (readFile ./flake.lock)).nodes;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      jdk = java.defaultPackage.${system};
      bazel_4 = with pkgs; callPackage "${nixpkgs}/pkgs/development/tools/build-managers/bazel/bazel_4/default.nix" rec {
        inherit (darwin) cctools;
        inherit (darwin.apple_sdk.frameworks) CoreFoundation CoreServices Foundation;
        stdenv = pkgs.stdenv;
        bazel_self = bazel_4;

        buildJdk = jdk11;
        buildJdkName = "java11";
        runJdk = jdk;
      };
    in
    rec {
      devShell.${system} = pkgs.callPackage ./shell.nix {
        inherit jdk bazel_4;
      };
    };
}
