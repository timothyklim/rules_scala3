deps-update:
	REPIN=1 bazel run @unpinned_annex//:pin
	REPIN=1 bazel run @unpinned_annex_scalafmt//:pin
	REPIN=1 bazel run @unpinned_annex_proto//:pin
	cd tests && REPIN=1 bazel run @unpinned_annex_test//:pin

deps-outdated:
	bazel run @annex//:outdated
	bazel run @annex_scalafmt//:outdated
	bazel run @annex_proto//:outdated
	cd tests && bazel run @annex_test//:outdated

bzl-lint:
	fd -E bazel/deps -E 3rdparty -E cargo "^(.*BUILD|WORKSPACE|.*\\.bzl)" . -x buildifier --lint=warn --warnings=all \;

bzl-fmt:
	fd -E bazel/deps -E 3rdparty -E cargo "^(.*BUILD|WORKSPACE|.*\\.bzl)" . -x buildifier

nix-fmt:
	find . -name "*.nix" | xargs nixpkgs-fmt

scala-fmt:
	scalafmt -c .scalafmt.conf --mode changed --non-interactive --quiet .

fmt: scala-fmt nix-fmt bzl-fmt
