load("//rules:scala.bzl", "scala_binary")

scala_binary(
    name = "jmh",
    srcs = glob(["*.scala"]),
    main_class = "rules_scala3.jmh.JmhRunner",
    scala = "//scala:bootstrap_3_3",
    visibility = ["//visibility:public"],
    deps = [
        "@//3rdparty/jvm/org/openjdk/jmh:jmh_core",
    ],
)
