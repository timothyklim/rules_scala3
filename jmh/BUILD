load("//jmh:jmh.bzl", "scala_jmh_benchmark")
load("@rules_java//java:defs.bzl", "java_binary")

java_binary(
    name = "generator",
    main_class = "org.openjdk.jmh.generators.bytecode.JmhBytecodeGenerator",
    runtime_deps = [
        "@//3rdparty/jvm/org/openjdk/jmh:jmh_core",
        "@//3rdparty/jvm/org/openjdk/jmh:jmh_generator_asm",
        "@//3rdparty/jvm/org/openjdk/jmh:jmh_generator_bytecode",
        "@//3rdparty/jvm/org/openjdk/jmh:jmh_generator_reflection",
    ],
)

scala_jmh_benchmark(
  name = "test",
  srcs = ["ArrayBench.scala"],
)
