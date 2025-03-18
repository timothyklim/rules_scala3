genrule(
    name = "gen_BlockSystemExitAgent.jar",
    srcs = ["BlockSystemExitAgent.java"],
    outs = ["BlockSystemExitAgent.jar"],
    cmd = """
        $(JAVABASE)/bin/javac --enable-preview --release 24 -d agentclasses $(location BlockSystemExitAgent.java)
        cat > agent.mf << EOF
Premain-Class: rules_scala3.common.worker.BlockSystemExitAgent
Can-Retransform-Classes: true
EOF
        $(JAVABASE)/bin/jar --create --file=$(location BlockSystemExitAgent.jar) --manifest=agent.mf -C agentclasses .
    """,
    toolchains = ["@bazel_tools//tools/jdk:current_java_runtime"],
    tools = ["@bazel_tools//tools/jdk:current_java_runtime"],
    visibility = ["//visibility:public"],
)

java_import(
    name = "agent",
    jars = ["BlockSystemExitAgent.jar"],
    visibility = ["//visibility:public"],
)
