def _scalafix_runner_impl(ctx):

    toolchain = ctx.attr.toolchain.label
    scalafix_opts = ctx.attr.opts or ""

    targets = " ".join(['"%s"' % t.label for t in ctx.attr.targets])
    excluded_targets = " ".join(['"%s"' % ("-" + et.label) for et in ctx.attr.excluded_targets])

    script_content = """#!/usr/bin/env bash

set -e

workspace="$BUILD_WORKSPACE_DIRECTORY"

cd "$workspace"

toolchain="%s"
scalafix_opts="%s"

targets=(%s)
excluded_targets=(%s)

# Filter targets
echo "Targets: ${targets[*]}"
echo "Excluded Targets: ${excluded_targets[*]}"
filtered_targets=$(
  bazel query \\
    "kind('scala(_binary|_library|_test|js_library)', set(${targets[@]}) except set(${excluded_targets[@]}))" \\
    2>/dev/null
)

if [[ -z "$filtered_targets" ]]; then
  echo "No matching targets found."
  exit 0
fi

# Build targets
echo "Building targets..."
bazel build --extra_toolchains="$toolchain" -- $filtered_targets

# Run scalafix
exec_root=$(bazel info execution_root 2>/dev/null)
for target in $filtered_targets; do
  echo "Running scalafix for $target..."
  files=$(
    bazel query "$target" --output=streamed_jsonproto 2>/dev/null | \\
      jq -r '.rule.attribute[]? | select(.name=="srcs" and .stringListValue!=null) | .stringListValue[]'
  )

  if [[ -z "$files" ]]; then
    continue
  fi

  # Get the source files for the target
  files=$(
    bazel query "kind('source file', deps($target))" --output=label 2>/dev/null | \
      sed 's|^//|./|' | sed 's|:|/|'
  )

  if [[ -z "$files" ]]; then
    echo "No source files found for $target"
    continue
  fi

  scalac_opts=$(
    bazel query "$toolchain" --output=streamed_jsonproto 2>/dev/null | \
      jq -r '.rule.attribute[] | select(.name=="global_scalacopts" and .stringListValue!=null) | .stringListValue[]'
  )

  required_options="-Wunused:all"
  if [[ "$scalac_opts" != *"$required_options"* ]]; then
    scalac_opts="$scalac_opts $required_options"
  fi

  scala_version=$(
    bazel cquery "$target" --output=starlark --starlark:expr \\
      'providers(target).get("java").scala_info.toolchain.scala_version' 2>/dev/null
  )

  classpath="--classpath $exec_root/$(bazel cquery "$target.jar" --output files 2>/dev/null)"
  sourceroot="--sourceroot $workspace"

  scalafix_cmd="scalafix ${scalafix_opts//:/ } --scala-version $scala_version $sourceroot $classpath ${scalac_opts[*]/#/--scalac-options } $files"
  echo "$scalafix_cmd"
  eval "$scalafix_cmd"
done
""" % (toolchain, scalafix_opts, targets, excluded_targets)

    # Write the script to an output file
    script_file = ctx.actions.declare_file("run_scalafix.sh")
    ctx.actions.write(script_file, script_content)

    # Return the script file as an executable output
    return DefaultInfo(
        executable=script_file,
        files=depset([script_file]),
    )

scalafix_runner = rule(
    implementation=_scalafix_runner_impl,
    attrs={
        "toolchain": attr.label(mandatory=True),
        "opts": attr.string(default=":--verbose:--config .scalafix.conf"),
        "targets": attr.label_list(mandatory=True, allow_files=False),
        "excluded_targets": attr.label_list(default=[], allow_files=False),
    },
    executable=True,  # Mark this rule as producing an executable
)
