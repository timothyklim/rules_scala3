{ pkgs, jdk, bazel-pre }:

with pkgs;

let
  jdk = openjdk16_headless;
  bazel = stdenv.mkDerivation {
    name = "bazel_custom";
    phases = [ "installPhase" ];
    installPhase = ''
      mkdir -p $out/bin
      cat <<'EOF' > $out/bin/bazel
      #!/bin/sh
      ${bazel-pre}/bin/bazel --server_javabase=${jdk.home} $@
      EOF
      chmod +x $out/bin/bazel
    '';
  };
in
mkShell {
  name = "rules_scala-env";
  nativeBuildInputs = [ jdk ];
  buildInputs = [ bash bazel bazel-buildtools python2 gnumake fd nixpkgs-fmt ];

  shellHook = ''
    export PATH=${python2}/bin:$PATH

    export JAVA_HOME=${jdk.home}
    export JAVA_INCLUDE_PATH=${jdk.home}/include
    export JNI_INCLUDE_DIRS=${jdk.home}/include
  '';
}
