load("//rules:scala.bzl", "scala_binary")

scala_binary(
    name = "deps",
    srcs = ["//deps/src/main:deps"],
    args = [
        "--project-root=.",
        "--scala-version=3.5.1",  #TODO
    ],
    main_class = "deps.src.main.Deps",
    resources = ["//deps/src/main/templates:jar_artifact_callback"],
    scala = "//scala:bootstrap_3",
    visibility = ["//visibility:public"],
    deps = [
        "@annex_deps//:com_github_scopt_scopt_3",
        "@annex_deps//:org_scala_sbt_librarymanagement_core_3",
        "@annex_deps//:org_scala_sbt_librarymanagement_coursier_3",
    ],
)
