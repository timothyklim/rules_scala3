{ pkgs, jdk }:

with pkgs;

let
  bazel_4 = stdenv.mkDerivation {
    name = "bazel_custom";
    phases = [ "installPhase" ];
    installPhase = ''
      mkdir -p $out/bin
      cat <<'EOF' > $out/bin/bazel
      #!/bin/sh
      ${pkgs.bazel_4}/bin/bazel --server_javabase=${jdk.home} $@
      EOF
      chmod +x $out/bin/bazel
    '';
  };
in
mkShell {
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
