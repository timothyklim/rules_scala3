deps-update:
	rg -l 'maven_install_json' --glob '*.bzl' --glob 'WORKSPACE' | xargs sed -i -E 's/[^#]maven_install_json/#maven_install_json/g'
	
	bazel run @annex_deps//:pin
	bazel run @annex//:pin
	bazel run @annex_scalafmt//:pin
	cd tests && bazel run @annex_test//:pin

	rg -l '#maven_install_json' --glob '*.bzl' --glob 'WORKSPACE' | xargs sed -i 's/#maven_install_json/maven_install_json/g'

	REPIN=1 bazel run @unpinned_annex_deps//:pin
	REPIN=1 bazel run @unpinned_annex//:pin
	REPIN=1 bazel run @unpinned_annex_scalafmt//:pin
	cd tests && REPIN=1 bazel run @unpinned_annex_test//:pin

deps-outdated:
	bazel run @annex//:outdated
	bazel run @annex_deps//:outdated
	bazel run @annex_scalafmt//:outdated
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
