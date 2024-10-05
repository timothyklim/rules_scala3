{ pkgs }:

with pkgs;

let
  stdenv = if pkgs.stdenv.hostPlatform.isDarwin then pkgs.llvmPackages_16.stdenv else pkgs.stdenv;
in
mkShell {
  name = "rules_scala-env";
  nativeBuildInputs = [ jdk ];
  buildInputs = [ bash bazel_7 bazel-buildtools python3 just fd ripgrep gnused nixpkgs-fmt ];
  LOCALE_ARCHIVE = lib.optionals stdenv.isLinux "${glibcLocales}/lib/locale/locale-archive";
}
