load("//rules:scala.bzl", "scala_binary")

scala_binary(
    name = "deps",
    srcs = [
        "//:dependencies",
        "//deps/src:deps",
    ],
    args = [
        "--project-root=.",
        "--scala-version=3.6.3",
        "--dependencies=rules_scala3.Dependencies",
    ],
    main_class = "rules_scala3.deps.src.Deps",
    scala = "//scala:bootstrap_3",
    visibility = ["//visibility:public"],
    deps = [
        "@maven//:io_get_coursier_coursier_2_13",
        "@maven//:org_scala_sbt_librarymanagement_core_3",
        "@maven//:org_scala_sbt_librarymanagement_coursier_3",
        "@rules_scala3//3rdparty/jvm/com/github/scopt",
    ],
)
