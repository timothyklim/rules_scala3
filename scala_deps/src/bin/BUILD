load("//rules:scala.bzl", "scala_binary")

scala_binary(
    name = "scala_deps_binary",
    srcs = glob(["*.scala"]),
    main_class = "bin.Deps",
    resource_strip_prefix = package_name(),
    resources = ["templates/jar_artifact_callback.bzl"],
    scala = "//scala:bootstrap_3",
    visibility = ["//visibility:public"],
    deps = [
        "//scala_deps/src/lib:scala_deps_library",
        "@annex_deps//:com_github_scopt_scopt_3",
        "@annex_deps//:org_scala_sbt_librarymanagement_core_3",
        "@annex_deps//:org_scala_sbt_librarymanagement_coursier_3",
    ],
)
