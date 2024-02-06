package rules_scala
package workers.zinc.compile

import java.nio.file.Path

final case class ZincContext(rootDir: Path, tmpDir: Path, depsCache: Path | Null)
