{ pkgs }:

with pkgs;

let
  stdenv = if pkgs.stdenv.hostPlatform.isDarwin then pkgs.llvmPackages_16.stdenv else pkgs.stdenv;
in mkShell.override { inherit stdenv; } {
  name = "rules_scala-env";
  nativeBuildInputs = [ jdk ];
  buildInputs = [ bash bazel bazel-buildtools python3 just fd nixpkgs-fmt ];
  LOCALE_ARCHIVE = lib.optionals stdenv.isLinux "${glibcLocales}/lib/locale/locale-archive";
}
