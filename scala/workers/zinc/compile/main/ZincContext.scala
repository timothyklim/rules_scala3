package rules_scala3
package workers.zinc.compile

import java.nio.file.Path

final case class ZincContext(rootDir: Path, tmpDir: Path, depsCache: Path | Null)
