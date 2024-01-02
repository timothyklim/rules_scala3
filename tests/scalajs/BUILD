load("@rules_scala3//rules:scalajs.bzl", "scalajs_library", "scalajs_link")

scalajs_library(
    name = "app",
    srcs = ["ScalaJsApp.scala"],
    deps = ["//3rdparty/jvm/org/scala_js:scalajs_dom_sjs1"],
)

scalajs_link(
    name = "scalajs",
    full_opt = True,
    main_class = "tests.ScalaJsApp",
    main_method = "run",
    main_method_with_args = False,
    module_kind = "es",
    visibility = ["//visibility:public"],
    deps = [":app"],
)
