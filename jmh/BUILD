load("@rules_scala3//jmh:jmh.bzl", "scala_jmh_benchmark")
load("@rules_java//java:defs.bzl", "java_binary")

java_binary(
    name = "generator",
    main_class = "org.openjdk.jmh.generators.bytecode.JmhBytecodeGenerator",
    visibility = ["//visibility:public"],
    runtime_deps = [
        "@rules_scala3//3rdparty/jvm/org/openjdk/jmh:jmh_core",
        "@rules_scala3//3rdparty/jvm/org/openjdk/jmh:jmh_generator_asm",
        "@rules_scala3//3rdparty/jvm/org/openjdk/jmh:jmh_generator_bytecode",
        "@rules_scala3//3rdparty/jvm/org/openjdk/jmh:jmh_generator_reflection",
    ],
)

scala_jmh_benchmark(
    name = "test",
    srcs = ["ArrayBench.scala"],
)
