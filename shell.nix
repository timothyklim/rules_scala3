{ pkgs, jdk, bazel_4 }:

with pkgs; mkShell {
  name = "rules_scala-env";
  nativeBuildInputs = [ bash bazel_4 bazel-buildtools ];
  buildInputs = [ python2 gnumake fd ];

  shellHook = ''
    export PATH=${python2}/bin:$PATH

    export JAVA_HOME=${jdk.home}
    export JAVA_INCLUDE_PATH=${jdk.home}/include
    export JNI_INCLUDE_DIRS=${jdk.home}/include
  '';
}
