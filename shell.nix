{ pkgs ? import <nixpkgs> { } }:

with pkgs;

let
  jdk = jdk11;
  bazel_4 = callPackage <nixpkgs/pkgs/development/tools/build-managers/bazel/bazel_4> rec {
    inherit (darwin) cctools;
    inherit (darwin.apple_sdk.frameworks) CoreFoundation CoreServices Foundation;
    stdenv = pkgs.stdenv;
    bazel_self = bazel_4;

    buildJdk = jdk;
    buildJdkName = "java11";
    runJdk = jdk;
  };
in
mkShell {
  name = "rules_scala-env";
  nativeBuildInputs = [ bash bazel_4 bazel-buildtools ];
  buildInputs = [ python2 gnumake ];

  shellHook = ''
    export PATH=${python2}/bin:$PATH

    export JAVA_HOME=${jdk.home}
    export JAVA_INCLUDE_PATH=${jdk.home}/include
    export JNI_INCLUDE_DIRS=${jdk.home}/include
  '';
}
