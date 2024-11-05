#!/bin/sh -e

#
# Regenerates the external dependencies lock file using rules_jvm_external
#

cd "$(dirname "$0")/.."
echo "$(dirname "$0")/.."

echo "generating dependencies for tests workspace"
cd "tests"
bazel run @unpinned_annex_test//:pin
