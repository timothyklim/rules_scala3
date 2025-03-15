// https://openjdk.org/jeps/486#Appendix

package rules_scala3.common.worker;

import module java.base;
import module java.instrument;

public class BlockSystemExitAgent {
    /*
     * Before the application starts, register a transformer of class files.
     */
    public static void premain(String agentArgs, Instrumentation inst) {
        var transformer = new ClassFileTransformer() {
            @Override
            public byte[] transform(ClassLoader      loader,
                                    String           className,
                                    Class<?>         classBeingRedefined,
                                    ProtectionDomain protectionDomain,
                                    byte[]           classBytes) {
                if (loader != null && loader != ClassLoader.getPlatformClassLoader()) {
                    return blockSystemExit(classBytes);
                } else {
                    return null;
                }
            }
        };
        inst.addTransformer(transformer, true);
    }

    /*
     * Rewrite every invokestatic of System::exit(int) to an athrow of RuntimeException.
     */
    private static byte[] blockSystemExit(byte[] classBytes) {
        var modified = new AtomicBoolean();
        ClassFile cf = ClassFile.of(ClassFile.DebugElementsOption.DROP_DEBUG);
        ClassModel classModel = cf.parse(classBytes);

        Predicate<MethodModel> invokesSystemExit =
            methodModel -> methodModel.code()
                                      .map(codeModel ->
                                             codeModel.elementStream()
                                                      .anyMatch(BlockSystemExitAgent::isInvocationOfSystemExit))
                                      .orElse(false);

        CodeTransform rewriteSystemExit =
            (codeBuilder, codeElement) -> {
                if (isInvocationOfSystemExit(codeElement)) {
                    var runtimeException = ClassDesc.of("java.lang.RuntimeException");
                    codeBuilder.dup() // Duplicate the exit code
                               .invokestatic(
                                   ClassDesc.of("java.lang.String"),
                                   "valueOf",
                                   MethodTypeDesc.ofDescriptor("(I)Ljava/lang/String;")
                               )
                               .ldc("System.exit not allowed: ") // Load constant string
                               .swap() // Swap so the code is first, text is second
                               .invokevirtual(
                                   ClassDesc.of("java.lang.String"),
                                   "concat",
                                   MethodTypeDesc.ofDescriptor("(Ljava/lang/String;)Ljava/lang/String;")
                               )
                               .new_(runtimeException)
                               .dup_x1()
                               .swap()
                               .invokespecial(
                                   runtimeException,
                                   "<init>",
                                   MethodTypeDesc.ofDescriptor("(Ljava/lang/String;)V"),
                                   false
                               )
                               .athrow();
                    modified.set(true);
                } else {
                    codeBuilder.with(codeElement);
                }
            };

        ClassTransform ct = ClassTransform.transformingMethodBodies(invokesSystemExit, rewriteSystemExit);
        byte[] newClassBytes = cf.transform(classModel, ct);
        if (modified.get()) {
            return newClassBytes;
        } else {
            return null;
        }
    }

    private static boolean isInvocationOfSystemExit(CodeElement codeElement) {
        return codeElement instanceof InvokeInstruction i
                && i.opcode() == Opcode.INVOKESTATIC
                && "java/lang/System".equals(i.owner().asInternalName())
                && "exit".equals(i.name().stringValue())
                && "(I)V".equals(i.type().stringValue());
    }
}
