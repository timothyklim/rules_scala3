{
  description = "Bazel rules_scala flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    java.url = "github:TawasalMessenger/jdk-flake";
  };

  outputs = { self, nixpkgs, flake-utils, java }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "x86_64-darwin" ] (system:
      let
        pkgs = import nixpkgs { inherit system; };
        jdk = java.defaultPackage.${system};
      in
      rec {
        devShell = pkgs.callPackage ./shell.nix { inherit jdk; };
      });
}
