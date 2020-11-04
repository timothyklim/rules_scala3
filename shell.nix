{ pkgs ? import <nixpkgs> {} }:

with pkgs; pkgs.mkShell {
  name = "rules_scala-env";
  nativeBuildInputs = [ bash bazel_3 bazel-buildtools ];
  buildInputs = [ python2 gnumake ];

  shellHook = ''
    export PATH=${python2}/bin:$PATH
  '';
}
