load("@rules_scala3//rules:scala.bzl", "scala_import")
scala_import(
    name = "jmh_core",
    jars = [
        "//external:jar/org/openjdk/jmh/jmh_core"
    ],
    runtime_deps = [
        "//3rdparty/jvm/net/sf/jopt_simple:jopt_simple",
        "//3rdparty/jvm/org/apache/commons:commons_math3"
    ],
    visibility = [
        "//visibility:public"
    ]
)

scala_import(
    name = "jmh_generator_asm",
    jars = [
        "//external:jar/org/openjdk/jmh/jmh_generator_asm"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/ow2/asm:asm",
        ":jmh_core",
        ":jmh_generator_reflection"
    ],
    visibility = [
        "//visibility:public"
    ]
)

scala_import(
    name = "jmh_generator_bytecode",
    jars = [
        "//external:jar/org/openjdk/jmh/jmh_generator_bytecode"
    ],
    runtime_deps = [
        ":jmh_core",
        ":jmh_generator_asm",
        ":jmh_generator_reflection"
    ],
    visibility = [
        "//visibility:public"
    ]
)

scala_import(
    name = "jmh_generator_reflection",
    jars = [
        "//external:jar/org/openjdk/jmh/jmh_generator_reflection"
    ],
    runtime_deps = [
        ":jmh_core"
    ],
    visibility = [
        "//visibility:public"
    ]
)
