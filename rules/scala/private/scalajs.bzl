load("//rules:scala.bzl", "scala_binary", "scala_library")

def scalajs_library(name, srcs, deps = [], visibility = None, scalacopts = [], scala = None, deps_used_whitelist = []):
    """Make scalajs library for provided sources"""
    scala_library(
        name = name,
        srcs = srcs,
        visibility = visibility,
        deps_used_whitelist = [
            "@scalajs_library_2_13//jar",
        ] + deps_used_whitelist,
        deps = [
            "@scalajs_library_2_13//jar",
        ] + deps,
        scalacopts = ["-scalajs"] + scalacopts,
        scala = scala,
    )

def scalajs_binary(name, srcs, deps, main_class = "auto", main_method = "main", main_method_with_args = True, module_kind = "no-module", scalacopts = [], scala = None, deps_used_whitelist = [], out = "index.js"):
    """Compiles scalajs sources"""
    classes = name + "_classes"

    scalajs_library(
        name = classes,
        srcs = srcs,
        deps = deps,
        visibility = ["//visibility:private"],
        scalacopts = scalacopts,
        scala = scala,
        deps_used_whitelist = deps_used_whitelist,
    )
    all_deps = [":" + classes, "@scalajs_library_2_13//jar", "@scalajs_library_3_1_0_sjs//jar"] + deps
    all_locations = []
    for dep in all_deps:
        all_locations.append("$(locations " + dep + ")")
    all_locations_str = " ".join(all_locations)

    with_args = "true" if main_method_with_args else "false"
    native.genrule(
        name = name,
        outs = [out],
        cmd = "$(location @rules_scala3//scala/workers/scalajs:scalajs_linker) --main-class {} --main-method {} --with-args {} --module {} --dest $@ {}".format(main_class, main_method, with_args, module_kind, all_locations_str),
        tools = ["@rules_scala3//scala/workers/scalajs:scalajs_linker"] + all_deps,
    )
