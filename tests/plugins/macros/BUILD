load("@rules_scala3//rules:scala.bzl", "scala_binary", "scala_library")

scala_library(
    name = "bad_compile",
    srcs = ["TestMacro.scala"],
    scala = "@rules_scala3//scala:3_4",
    deps = [
        ":macro_bad",
        "@scala_reflect_2_13//jar",
    ],
)

scala_library(
    name = "macro",
    srcs = ["Macro.scala"],
    macro = True,
    scala = "@rules_scala3//scala:3_4",
    deps = [
        ":util",
        "@scala_reflect_2_13//jar",
    ],
)

scala_library(
    name = "macro_only",
    srcs = ["MacroOnly.scala"],
    macro = True,
    scala = "@rules_scala3//scala:3_4",
    deps = [
        ":macro",
        "@scala_reflect_2_13//jar",
    ],
)

scala_library(
    name = "macro_bad",
    srcs = ["Macro.scala"],
    scala = "@rules_scala3//scala:3_4",
    deps = [
        ":util",
        "@scala_reflect_2_13//jar",
    ],
)

scala_library(
    name = "util",
    srcs = ["MacroUtil.scala"],
    scala = "@rules_scala3//scala:3_4",
    deps = ["@scala_reflect_2_13//jar"],
)

scala_binary(
    name = "test_macro",
    srcs = ["TestMacro.scala"],
    scala = "@rules_scala3//scala:3_4",
    deps = [":macro"],
)

scala_binary(
    name = "test_macro_only",
    srcs = ["TestMacroOnly.scala"],
    deps_used_whitelist = [
        ":macro_only",
    ],
    scala = "@rules_scala3//scala:3_4",
    deps = [
        ":macro",
        ":macro_only",
    ],
)
