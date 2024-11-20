load("//rules:scala.bzl", "scala_binary")
load("@rules_scala3//deps:scala_deps.bzl", "scala_deps")

filegroup(
    name = "dependencies",
    srcs = ["Dependencies.scala"],
    visibility = ["//visibility:public"],
)

scala_deps(
    name = "scala_deps",
    src = "//rules/scalafix:dependencies",
    dependencies = "rules_scala3.rules.scalafix.Dependencies",
)

scala_binary(
    name = "scalaix",
    srcs = ["//rules/scalafix/src:scalafix"],
    args = [
        "--toolchain=//my/toolchain",
        "--opts=:--verbose:--config",
    ],
    main_class = "rules_scala3.rules.scalafix.src.Main",
    scala = "//scala:bootstrap_3",
    visibility = ["//visibility:public"],
    deps = [
        "@rules_scala3//3rdparty/jvm/com/github/scopt",
    ],
)
