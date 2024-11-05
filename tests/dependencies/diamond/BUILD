load("@rules_scala3//rules:scala.bzl", "scala_library")

#
# diamond dep DAG:
#
#   /--> B1 --\
# C            > A
#   \--> B2 --/
#

scala_library(
    name = "A",
    srcs = ["A.scala"],
    scala = "@rules_scala3//scala:3_4",
    tags = ["manual"],
)

scala_library(
    name = "B1",
    srcs = ["B1.scala"],
    scala = "@rules_scala3//scala:3_4",
    tags = ["manual"],
    deps = [":A"],
)

scala_library(
    name = "B2",
    srcs = ["B2.scala"],
    scala = "@rules_scala3//scala:3_4",
    tags = ["manual"],
    deps = [":A"],
)

scala_library(
    name = "C",
    srcs = ["C.scala"],
    scala = "@rules_scala3//scala:3_4",
    tags = ["manual"],
    deps = [
        ":B1",
        ":B2",
    ],
)
