{ pkgs }:

with pkgs;

mkShell {
  name = "rules_scala-env";
  nativeBuildInputs = [ jdk ];
  buildInputs = [ bash bazel bazel-buildtools python3 just fd nixpkgs-fmt ];
  LOCALE_ARCHIVE = "${glibcLocales}/lib/locale/locale-archive";
}
