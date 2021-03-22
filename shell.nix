{ pkgs, jdk, bazel_4 }:

with pkgs; mkShell {
  name = "rules_scala-env";
  nativeBuildInputs = [ jdk ];
  buildInputs = [ bash bazel_4 bazel-buildtools python2 gnumake fd nixpkgs-fmt ];

  shellHook = ''
    export PATH=${python2}/bin:$PATH

    export JAVA_HOME=${jdk.home}
    export JAVA_INCLUDE_PATH=${jdk.home}/include
    export JNI_INCLUDE_DIRS=${jdk.home}/include
  '';
}
