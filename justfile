deps-update:
  #!/usr/bin/env bash
  set -euxo pipefail

  bazel run //:scala_deps
  bazel run //scala:scala_deps
  bazel run //rules/scala_proto:scala_deps

  cd tests && bazel run //:scala_deps

deps-outdated:
	cd tests && bazel run @annex_test//:outdated

bzl-lint:
	fd -E bazel/deps -E 3rdparty -E cargo "^(.*BUILD|WORKSPACE|.*\\.bzl)" . -x buildifier --lint=warn --warnings=all \;

bzl-fmt:
	fd -E bazel/deps -E 3rdparty -E cargo "^(.*BUILD|WORKSPACE|.*\\.bzl)" . -x buildifier

nix-fmt:
	find . -name "*.nix" | xargs nixpkgs-fmt

scala-fmt:
	scalafmt -c .scalafmt.conf --non-interactive

fmt: scala-fmt nix-fmt bzl-fmt

clean:
  bazel clean --expunge
  bazel sync --configure
