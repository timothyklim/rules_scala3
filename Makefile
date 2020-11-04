bzl-lint:
	find . -type f -iname "*.bazel" -o -iname "*.bzl" -o -iname BUILD -o -iname WORKSPACE | xargs buildifier --lint=warn --warnings=all

bzl-fmt:
	find . -type f -iname "*.bazel" -o -iname "*.bzl" -o -iname BUILD -o -iname WORKSPACE xargs buildifier

nix-fmt:
	find . -name "*.nix" | xargs nixpkgs-fmt

scala-fmt:
	scalafmt -c .scalafmt.conf --mode changed --non-interactive --quiet .

fmt: scala-fmt nix-fmt bzl-fmt
