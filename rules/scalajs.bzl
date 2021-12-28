load(
    "//rules/scala:private/scalajs.bzl",
    _scalajs_binary = "scalajs_binary",
    _scalajs_library = "scalajs_library",
)

scalajs_library = _scalajs_library

scalajs_binary = _scalajs_binary
