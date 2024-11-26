def _scalafix_runner_impl(ctx):
    # Dynamically generate the script content
    script_content = """#!/usr/bin/env bash

# Navigate to the Bazel workspace
workspace="$BUILD_WORKSPACE_DIRECTORY"
cd "$workspace"

# Variables
toolchain="{toolchain}"
opts="{opts}"
targets=({targets})
excluded_targets=({excluded_targets})

# Filter targets
echo "Filtering targets..."
readarray -t filtered_targets < <(bazel query \
    "kind('scala(_binary|_library|_test|js_library)', set(${targets[*]}) except set(${excluded_targets[*]}))" --output=label 2>/dev/null)

if [[ ${#filtered_targets[@]} -eq 0 ]]; then
    echo "No valid targets found to build."
    exit 1
fi

# Debug filtered targets
echo "Filtered targets: ${filtered_targets[@]}"

# Build targets
build_cmd="bazel build --extra_toolchains='$toolchain' -- ${filtered_targets[@]}"
echo "Building targets..."
echo "Command: $build_cmd"
if ! eval "$build_cmd"; then
    echo "BUILD FAILED, FIX AND TRY AGAIN"
    kill -INT $$
fi

# Run scalafix
exec_root="$(bazel info execution_root 2>/dev/null)"
toolchain_impl="$(
    bazel query "$toolchain" --output=streamed_jsonproto 2>/dev/null |
        jq -r '.rule.attribute[] | select(.name=="toolchain" and .explicitlySpecified==true) | .stringValue'
)"
for target in "${filtered_targets[@]}"; do
    target_json="$(bazel query "$target" --output=streamed_jsonproto 2>/dev/null)"

    readarray -t files < <(
        echo "$target_json" |
            jq -r '.rule.attribute[]? | select(.name=="srcs" and .stringListValue!=null) | .stringListValue[]' |
            while read -r source; do
                printf -- "--files %s\n" "$(bazel query "$source" --output location 2>/dev/null)"
            done
    )

    if [[ ${#files[@]} -eq 0 ]]; then
        continue
    fi

    if echo "$target_json" |
        jq -e '.rule.attribute[] | select(.name=="scala" and .explicitlySpecified==true)' >/dev/null; then
        actual_toolchain="$(echo "$target_json" | jq -r '.rule.attribute[] | select(.name=="scala") | .stringValue')"
    else
        actual_toolchain=$toolchain_impl
    fi

    readarray -t scalac_opts < <(
        # if 'enable_semanticdb = True' toolchain adds this under the hood
        if bazel query "$toolchain_impl" --output streamed_jsonproto 2>/dev/null |
            jq -e '.rule.attribute[] | select(.name=="enable_semanticdb" and .stringValue=="true")' >/dev/null; then
            echo "-Xsemanticdb"
        fi
        # scalacopts from toolchain
        bazel query "$actual_toolchain" --output streamed_jsonproto 2>/dev/null |
            jq -r '.rule.attribute[] | select(.name=="global_scalacopts" and .stringListValue!=null) | .stringListValue[]'
        # scalacopts passed when defining the target
        echo "$target_json" |
            jq -r '.rule.attribute[] | select(.name=="scalacopts" and .stringListValue!=null) | .stringListValue[]'
    )

    scala_version="$(
        bazel cquery "$target" --output starlark --starlark:expr \
            'providers(target).get("java").scala_info.toolchain.scala_version' 2>/dev/null
    )"

    cs="--classpath $exec_root/$(bazel cquery "$target.jar" --output files 2>/dev/null)"

    sr="--sourceroot $(bazel info workspace 2>/dev/null)"

    scalafix_cmd="scalafix ${scalafix_opts//:/ } --scala-version $scala_version $sr $cs ${scalac_opts[*]/#/--scalac-options } ${files[*]%%:*}"
    echo "\nTrying to fix $target"
    echo "Command: $scalafix_cmd"
    eval "$scalafix_cmd"
done
""".replace(
        "{toolchain}", str(ctx.attr.toolchain.label)
    ).replace(
        "{opts}", ctx.attr.opts
    ).replace(
        "{targets}", " ".join(['"%s"' % t for t in ctx.attr.targets])
    ).replace(
        "{excluded_targets}", " ".join(['"%s"' % t for t in ctx.attr.excluded_targets])
    )

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
        "opts": attr.string(default="--verbose --config .scalafix.conf"),
        "targets": attr.string_list(mandatory=True),  # String list for patterns
        "excluded_targets": attr.string_list(default=[]),
    },
    executable=True,
)
