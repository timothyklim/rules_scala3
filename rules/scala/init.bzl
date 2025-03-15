load("//3rdparty:workspace.bzl", "maven_dependencies")
load("//rules/scala_proto/3rdparty:workspace.bzl", maven_dependencies_scala_proto = "maven_dependencies")
load("//rules/scalafmt:config.bzl", "scalafmt_default_config")
load("//rules/scalafmt/3rdparty:workspace.bzl", maven_dependencies_scalafmt = "maven_dependencies")
load("//scala/3rdparty:workspace.bzl", maven_dependencies_scala = "maven_dependencies")

def load_maven_dependencies():
    maven_dependencies()
    maven_dependencies_scala_proto()
    maven_dependencies_scalafmt()
    maven_dependencies_scala()

def rules_scala3_init():
    load_maven_dependencies()
    scalafmt_default_config(".scalafmt.conf")
