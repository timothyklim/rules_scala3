load("@rules_scala3//jmh:jmh.bzl", "scala_jmh_benchmark")
load("@rules_scala3//rules:scala.bzl", "scala_binary")

scala_binary(
    name = "runner",
    srcs = ["JmhRunner.scala"],
    main_class = "rules_scala3.jmh.JmhRunner",
    scala = "//scala:bootstrap_3",
    visibility = ["//visibility:public"],
    deps = [
        "@rules_scala3//3rdparty/jvm/com/github/scopt",
        "@rules_scala3//3rdparty/jvm/org/openjdk/jmh:jmh_core",
        "@rules_scala3//3rdparty/jvm/org/openjdk/jmh:jmh_generator_asm",
        "@rules_scala3//3rdparty/jvm/org/openjdk/jmh:jmh_generator_bytecode",
        "@rules_scala3//3rdparty/jvm/org/openjdk/jmh:jmh_generator_reflection",
        "@rules_scala3//rules/third_party/jarhelper",
    ],
)
