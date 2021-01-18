{ pkgs ? import <nixpkgs> {} }:

let
  nixpkgsPinned = import
    (fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/6a2dd6cf4688a5be5f03e34a7c86c02133f6c8a7.tar.gz";
      sha256 = "09s6jjq5hl06lrmamd43k6i1ayg0fc8ajfx8kr9qh53gyzirslhf";
    })
    { };
in
with pkgs; pkgs.mkShell {
  name = "rules_scala-env";
  nativeBuildInputs = [ bash nixpkgsPinned.bazel_4 nixpkgsPinned.bazel-buildtools ];
  buildInputs = [ python2 gnumake ];

  shellHook = ''
    export PATH=${python2}/bin:$PATH
  '';
}
