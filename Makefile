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
	find . -type f -iname "*.bazel" -o -iname "*.bzl" -o -iname BUILD -o -iname WORKSPACE | xargs buildifier --lint=warn --warnings=all

bzl-fmt:
	find . -type f -iname "*.bazel" -o -iname "*.bzl" -o -iname BUILD -o -iname WORKSPACE xargs buildifier

nix-fmt:
	find . -name "*.nix" | xargs nixpkgs-fmt

scala-fmt:
	scalafmt -c .scalafmt.conf --mode changed --non-interactive --quiet .

fmt: scala-fmt nix-fmt bzl-fmt
