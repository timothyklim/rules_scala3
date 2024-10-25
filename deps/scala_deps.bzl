load("@rules_scala3//rules:scala.bzl", "scala_binary")

def scala_deps(
        name,
        dependencies,
        src,
        project_root = ".",
        scala_version = "3.5.1-RC1",
        targets_dir_name = "jvm",
        targets_file_name = "BUILD"):
    destination = native.package_name() + "/3rdparty"

    scala_binary(
        name = name,
        main_class = "rules_scala3.deps.src.Deps",
        resources = ["@rules_scala3//deps/src/templates:jar_artifact_callback"],
        scala = "@rules_scala3//scala:bootstrap_3",
        visibility = ["//visibility:public"],
        srcs = ["@rules_scala3//deps/src:deps", src],
        args = [
            "--project-root=" + project_root,
            "--scala-version=" + scala_version,
            "--dependencies=" + dependencies,
            "--destination=" + destination,
            "--targets-dir-name=" + targets_dir_name,
            "--targets-file-name=" + targets_file_name,
        ],
        deps = [
            "@annex_deps//:com_github_scopt_scopt_3",
            "@annex_deps//:org_scala_sbt_librarymanagement_core_3",
            "@annex_deps//:org_scala_sbt_librarymanagement_coursier_3",
        ],
    )
