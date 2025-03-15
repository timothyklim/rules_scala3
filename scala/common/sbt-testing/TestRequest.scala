package rules_scala3
package common.sbt_testing

import sbt.testing.Logger

final case class TestRequest(
    val framework: String,
    val test: TestDefinition,
    val scopeAndTestName: String,
    val classpath: Seq[String],
    val logger: Logger,
    val testArgs: Seq[String]
)
