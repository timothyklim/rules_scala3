load("//rules:scala.bzl", "scala_binary")

scala_binary(
    name = "deps",
    srcs = [
        "//:dependencies",
        "//deps/src:deps",
    ],
    args = [
        "--project-root=.",
        "--scala-version=3.5.2",
        "--dependencies=rules_scala3.Dependencies",
    ],
    main_class = "rules_scala3.deps.src.Deps",
    scala = "//scala:bootstrap_3",
    visibility = ["//visibility:public"],
    deps = [
        "@annex_deps//:com_github_scopt_scopt_3",
        "@annex_deps//:org_scala_sbt_librarymanagement_core_3",
        "@annex_deps//:org_scala_sbt_librarymanagement_coursier_3",
    ],
)
