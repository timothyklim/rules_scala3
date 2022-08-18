load("//rules:scala.bzl", "scala_binary")

scala_binary(
    name = "scalajs_linker",
    srcs = glob(["*.scala"]),
    main_class = "rules_scala.workers.scalajs.ScalaJsWorker",
    scala = "//scala:bootstrap_3_2",
    visibility = ["//visibility:public"],
    jvm_flags = ["-Djava.security.manager=allow"],
    deps = [
        "//scala/common/worker",
        "//scala/workers/common",
        "@annex//:com_github_scopt_scopt_3",
        "@scalajs_ir_2_13",
        "@scalajs_js_envs_2_13",
        "@scalajs_linker_2_13",
        "@scalajs_linker_interface_2_13",
        "@scalajs_logging_2_13",
        "@scalajs_parallel_collections_1_0_4",
        "@scalajs_sbt_test_adapter_2_13",
        "@scalajs_test_bridge_2_13",
        "@scalajs_test_interface_2_13",
        "@scalajs_tools_2_13",
    ],
)
