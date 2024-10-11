load("@rules_scala3//rules:scala.bzl", "scala_binary")

def scala_deps(
        name = "scala_deps",
        project_root = ".",
        scala_version = "3.5.1", #TODO:
        destination = "3rdparty",
        targets_dir_name = "jvm",
        targets_file_name = "BUILD"):
    scala_binary(
        name = name,
        main_class = "deps.src.main.Deps",
        resources = ["//deps/src/main/templates:jar_artifact_callback"],
        scala = "//scala:bootstrap_3",
        visibility = ["//visibility:public"],
        srcs = ["//deps/src/main:deps"],
        args = [
            "--project-root=" + project_root,
            "--scala-version=" + scala_version,
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
