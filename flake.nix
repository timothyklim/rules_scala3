{
  description = "Bazel rules_scala flake";

  inputs = {
    nixpkgs.url = "nixpkgs/release-23.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    with flake-utils.lib; eachSystem [
      system.aarch64-darwin
      system.aarch64-linux
      system.x86_64-darwin
      system.x86_64-linux
    ]
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;

            overlays = [
              (self: super: with super; rec {
                remote_java_tools = stdenv.mkDerivation {
                  name = "remote_java_tools_linux";
                  src = fetchzip {
                    url = "https://github.com/bazelbuild/java_tools/releases/download/java_v12.6/java_tools_linux-v12.6.zip";
                    stripRoot = false;
                    hash = "sha256-p/x9F0PY5evOJepFJWDExs5whWYWF2RZjM6VsRABNyg=";
                  };

                  nativeBuildInputs = [ unzip ] ++ lib.optionals stdenv.isLinux [ autoPatchelfHook ];
                  buildInputs = [ gcc-unwrapped ];

                  buildPhase = ''
                    mkdir $out
                  '';

                  installPhase = ''
                    cp -Ra * $out/
                    touch $out/WORKSPACE
                  '';
                };
                jdk = super.openjdk17_headless;
                bazelrc = writeText "bazelrc" ''
                  startup --server_javabase=${jdk.home}

                  build --override_repository=${remote_java_tools.name}=${remote_java_tools}
                  fetch --override_repository=${remote_java_tools.name}=${remote_java_tools}
                  query --override_repository=${remote_java_tools.name}=${remote_java_tools}

                  # load default location for the system wide configuration
                  try-import /etc/bazel.bazelrc
                '';
                bazel = stdenv.mkDerivation {
                  name = "bazel_custom";
                  phases = [ "installPhase" ];
                  installPhase = ''
                    mkdir -p $out/bin
                    cat <<'EOF' > $out/bin/bazel
                    #!/bin/sh
                    set -e
                    ${bazel_6}/bin/bazel --bazelrc=${bazelrc} $@
                    EOF
                    chmod +x $out/bin/bazel
                  '';
                };
              })
            ];
          };
        in
        rec {
          devShell = pkgs.callPackage ./shell.nix { };
          formatter = nixpkgs.legacyPackages.${system}.nixpkgs-fmt;
        });
}
