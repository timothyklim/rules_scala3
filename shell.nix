{ pkgs ? import <nixpkgs> {} }:

let
  nixpkgsPinned = import (fetchTarball {
    # url = "https://github.com/NixOS/nixpkgs/archive/0592e0dcda648d6b54980dbcf244cc80ff3b7856.tar.gz";
    # sha256 = "1bb4jfdx401yjc7kyl4cmn90i8sadj3c623lgjanffya95c23kdz";
    url = "https://github.com/NixOS/nixpkgs/archive/7c349f2698781540fde71a5766d90d7d621b6109.tar.gz";
    sha256 = "1zmvnrnbcb2d6cajcsy600mfm57smyf076ixmjmn3i4kw97cv913";
  }) {};
in
with pkgs; pkgs.mkShell {
  name = "rules_scala-env";
  nativeBuildInputs = [ bash nixpkgsPinned.bazel_4 nixpkgsPinned.bazel-buildtools ];
  buildInputs = [ python2 gnumake ];

  shellHook = ''
    export PATH=${python2}/bin:$PATH
  '';
}
