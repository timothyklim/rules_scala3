deps-update:
	bazel run @annex//:pin
	bazel run @annex_scalafmt//:pin
	bazel run @annex_proto//:pin

	cd tests && bazel run @annex_test//:pin

deps-install:
	bazel run @unpinned_annex//:pin
	bazel run @unpinned_annex_scalafmt//:pin
	bazel run @unpinned_annex_proto//:pin

	cd tests && bazel run @unpinned_annex_test//:pin

bzl-lint:
	fd -E bazel/deps -E 3rdparty -E cargo "^(.*BUILD|WORKSPACE|.*\\.bzl)" . -x buildifier --lint=warn --warnings=all \;

bzl-fmt:
	fd -E bazel/deps -E 3rdparty -E cargo "^(.*BUILD|WORKSPACE|.*\\.bzl)" . -x buildifier

nix-fmt:
	find . -name "*.nix" | xargs nixpkgs-fmt

scala-fmt:
	scalafmt -c .scalafmt.conf --mode changed --non-interactive --quiet .

fmt: scala-fmt nix-fmt bzl-fmt
