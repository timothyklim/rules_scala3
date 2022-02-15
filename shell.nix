{ pkgs, jdk, bazel }:

with pkgs;

mkShell {
  name = "rules_scala-env";
  nativeBuildInputs = [ jdk ];
  buildInputs = [ bash bazel bazel-buildtools python3 just fd nixpkgs-fmt ];
}
