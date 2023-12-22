load("//rules:scala.bzl", "scala_binary")

scala_binary(
    name = "deps",
    srcs = glob(["*.scala"]),
    main_class = "rules_scala3.deps.Deps",
    resource_strip_prefix = package_name(),
    resources = ["templates/jar_artifact_callback.bzl"],
    scala = "//scala:bootstrap_3",
    visibility = ["//visibility:public"],
    deps = [
        "@deps//:com_github_scopt_scopt_3",
        "@deps//:org_scala_sbt_librarymanagement_core_3",
        "@deps//:org_scala_sbt_librarymanagement_coursier_3",
    ],
)
