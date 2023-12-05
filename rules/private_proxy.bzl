"Public entry point for compatibility when migrating rules to scala3"

load(
    "//rules/private:coverage_replacements_provider.bzl",
    _coverage_replacements_provider = "coverage_replacements_provider",
)
load(
    "//rules/private:phases.bzl",
    _phase_binary_deployjar = "phase_binary_deployjar",
    _phase_binary_launcher = "phase_binary_launcher",
    _phase_bootstrap_compile = "phase_bootstrap_compile",
    _phase_classpaths = "phase_classpaths",
    _phase_coda = "phase_coda",
    _phase_coverage_jacoco = "phase_coverage_jacoco",
    _phase_javainfo = "phase_javainfo",
    _phase_library_defaultinfo = "phase_library_defaultinfo",
    _phase_noop = "phase_noop",
    _phase_resources = "phase_resources",
    _phase_singlejar = "phase_singlejar",
    _phase_zinc_compile = "phase_zinc_compile",
    _phase_zinc_depscheck = "phase_zinc_depscheck",
    _run_phases = "run_phases",
)

coverage_replacements_provider = _coverage_replacements_provider
phase_bootstrap_compile = _phase_bootstrap_compile
phase_zinc_compile = _phase_zinc_compile
phase_zinc_depscheck = _phase_zinc_depscheck
phase_binary_deployjar = _phase_binary_deployjar
phase_binary_launcher = _phase_binary_launcher
phase_classpaths = _phase_classpaths
phase_coda = _phase_coda
phase_coverage_jacoco = _phase_coverage_jacoco
phase_javainfo = _phase_javainfo
phase_noop = _phase_noop
phase_resources = _phase_resources
phase_singlejar = _phase_singlejar
phase_library_defaultinfo = _phase_library_defaultinfo
run_phases = _run_phases
