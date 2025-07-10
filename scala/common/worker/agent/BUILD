genrule(
    name = "gen_BlockSystemExitAgent.jar",
    srcs = ["BlockSystemExitAgent.java"],
    outs = ["BlockSystemExitAgent.jar"],
    cmd = """
        JAVA_VERSION=$$($(JAVABASE)/bin/java -version 2>&1 | head -n 1 | sed 's/.*version "\\([0-9]*\\).*/\\1/')
        $(JAVABASE)/bin/javac --enable-preview --release $$JAVA_VERSION -d agentclasses $(location BlockSystemExitAgent.java)
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
