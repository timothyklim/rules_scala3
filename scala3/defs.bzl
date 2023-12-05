"""Public entry point to all Scala rules and supported APIs."""

load(
    "//scala3/private:worker_scala_binary.bzl",
    _worker_scala_binary = "worker_scala_binary",
)
load(
    "//scala3/private:worker_scala_library.bzl",
    _worker_scala_library = "worker_scala_library",
)

worker_scala_binary = _worker_scala_binary
# See @rules_scala3//scala3/private:worker_scala_binary.bzl for a complete description.

worker_scala_library = _worker_scala_library
# See @rules_scala3//scala3/private:worker_scala_library.bzl for a complete description.
