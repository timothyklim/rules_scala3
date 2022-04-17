load("@rules_scala3//rules:scala.bzl", "scala_library")

scala_library(
    name = "app",
    srcs = ["ScalaJsApp.scala"],
    scalacopts = [
        "-scalajs",
    ],
    deps = [
        "@annex_test//:org_scala_js_scalajs_dom_sjs1_3",
        # "@scalajs_library_2_13",
    ],
)
