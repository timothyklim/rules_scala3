load("//rules:scala.bzl", "scala_binary")

scala_binary(
    name = "scalaix",
    srcs = ["//scalafix/src:scalafix"],
    args = [
        "--toolchain=//my/toolchain",
        "--opts=:--verbose:--config",
    ],
    main_class = "rules_scala3.scalafix.src.Main",
    scala = "//scala:bootstrap_3",
    visibility = ["//visibility:public"],
    deps = [
        "@rules_scala3//3rdparty/jvm/com/github/scopt",
    ],
)
