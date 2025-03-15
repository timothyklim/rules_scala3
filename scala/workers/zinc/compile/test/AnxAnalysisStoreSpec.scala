package rules_scala3
package workers.zinc.compile

import java.nio.file.Paths

import munit.FunSuite

import workers.common.{AnnexLogger, LogLevel}

final class AnxAnalysisStoreSpec extends FunSuite:

  private lazy val _: Class[sbt.internal.util.Relation[?, ?]] = classOf[sbt.internal.util.Relation[?, ?]]
  private lazy val _: Class[munit.diff.Printer] = classOf[munit.diff.Printer]
  
  given AnnexLogger = AnnexLogger(LogLevel.Debug)
  given ZincContext = ZincContext(Paths.get("/tmp"), Paths.get("/tmp"), depsCache = null)

  test("serialize & deserialize"):
    val store = AnxAnalysisStore(Paths.get(""), Anxanalysis(AnxAnalysisStore.BinaryFormat))
