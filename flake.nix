{
  description = "Bazel rules_scala flake";

  inputs = {
    nixpkgs.url = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    bazel.url = "github:timothyklim/bazel-flake/jdk18";
    java.url = "github:TawasalMessenger/jdk-flake";
  };

  outputs = { self, nixpkgs, flake-utils, bazel, java }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "x86_64-darwin" ] (system:
      let
        pkgs = import nixpkgs { inherit system; };
        jdk = java.packages."${system}".jdk_18;
        bazel-pre = bazel.defaultPackage."${system}";
      in
      rec {
        devShell = pkgs.callPackage ./shell.nix { inherit jdk bazel-pre; };
      });
}
