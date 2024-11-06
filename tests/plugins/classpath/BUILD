load("@rules_scala3//rules:scala.bzl", "scala_library")

scala_library(
    name = "plugin-lib",
    srcs = ["plugin-lib.scala"],
    scala = "@rules_scala3//scala:3_4",
    tags = ["manual"],
)

_gen_plugin_xml_cmd = """
cat > $@ << EOF
<plugin>
  <name>plugin</name>
  <classname>plug.it.in.Plugin</classname>
</plugin>
"""

genrule(
    name = "gen-scalac-plugin.xml",
    outs = ["scalac-plugin.xml"],
    cmd = _gen_plugin_xml_cmd,
)

java_binary(
    name = "resources",
    classpath_resources = [
        ":gen-scalac-plugin.xml",
    ],
    create_executable = False,
)

scala_library(
    name = "plugin",
    srcs = ["plugin.scala"],
    resource_jars = [
        ":resources",
    ],
    scala = "@rules_scala3//scala:3_4",
    tags = ["manual"],
    deps = [
        ":plugin-lib",
        "@scala_compiler_2_13//jar",
        "@scala_reflect_2_13//jar",
    ],
)

scala_library(
    name = "inefficient-usage",
    srcs = ["usage.scala"],
    plugins = [
        ":plugin",
    ],
    scala = "@rules_scala3//scala:3_4",
    tags = ["manual"],
)
