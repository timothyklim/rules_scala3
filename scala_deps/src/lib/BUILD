load("@rules_scala3//rules:scala.bzl", "scala_library")

scala_library(
    name = "scala_deps_library",
    srcs = ["Dependencies.scala"],
    visibility = ["//visibility:public"],
    deps = [
        "@annex_deps//:org_scala_sbt_librarymanagement_core_3",
    ],
)
