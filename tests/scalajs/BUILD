load("@rules_scala3//rules:scala.bzl", "scala_library")

scala_library(
    name = "app",
    srcs = ["ScalaJsApp.scala"],
    scalacopts = [
        "-scalajs",
    ],
    deps = [
        "//3rdparty/jvm/org/scala_js:scalajs_dom_sjs1",
        # "@scalajs_library_2_13",
    ],
)
