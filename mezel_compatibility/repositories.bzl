"""Repository rule for loading mazel repository"""

def _mezel_compatibility_repository_impl(repository_ctx):
    repository_ctx.download_and_extract(
        url = "https://github.com/valdemargr/mezel/archive/%s.zip" % repository_ctx.attr.mezel_version,
        sha256 = repository_ctx.attr.sha256,
        type = "zip",
        stripPrefix = "mezel-%s" % repository_ctx.attr.mezel_version,
    )
    replacement_path = "aspects/aspect.bzl"
    repository_ctx.delete(replacement_path)
    repository_ctx.file(
        replacement_path,
        content = repository_ctx.read(Label("//mezel_compatibility:aspect.bzl")),
        executable = False,
    )

mezel_compatibility_repository = repository_rule(
    doc = "A repository rule that loads the mazel repository, adding compatibility with `rules_scala3`.",
    attrs = {
        "mezel_version": attr.string(
            doc = "The latest version can be found in the README of the upstream repository.",
            mandatory = True,
        ),
        "sha256": attr.string(
            doc = "The hash of the latest version can be found in the README of the upstream repository.",
            mandatory = True,
        ),
    },
    implementation = _mezel_compatibility_repository_impl,
)
