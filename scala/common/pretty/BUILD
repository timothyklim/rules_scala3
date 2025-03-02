load("//scala3:defs.bzl", "worker_scala_library")

worker_scala_library(
    name = "pretty",
    srcs = ["Pretty.scala"],
    deps = [
      "//scala/3rdparty/jvm/com/lihaoyi:fansi",
      "//scala/3rdparty/jvm/com/lihaoyi:pprint",
    ],
    visibility = ["//visibility:public"],
)
