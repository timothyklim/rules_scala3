package rules_scala3.deps

import java.io.File
import java.nio.file.{Files, Path, StandardOpenOption}
import java.util.Comparator

import sbt.librarymanagement.syntax.*

object MakeTree:
  def apply()(using vars: Vars)(using cfg: DepsCfg): Unit =
    val targets = Resolve()
    val bazelExtContent = BazelExt(targets)
    recreate(vars.targetsTreeFile.toPath())
    writeTree(targets, bazelExtContent)

  private def recreate(path: Path): Unit =
    if path.toFile().exists() then
      Files
        .walk(path)
        .map(_.toFile)
        .sorted(Comparator.reverseOrder())
        .parallel()
        .forEach(_.delete)
    Files.createDirectories(path)

  private def writeToFile(path: File, content: String): Unit =
    val dirname = path.getParentFile
    if !dirname.exists then dirname.mkdirs
    Files.writeString(path.toPath(), content, StandardOpenOption.CREATE, StandardOpenOption.WRITE, StandardOpenOption.TRUNCATE_EXISTING)

  private def writeTree(
      targets: Vector[Target],
      bazelExtContent: String
  )(using vars: Vars): Unit =
    // create bazel extension file
    writeToFile(vars.bazelExtFile, bazelExtContent)

    // create an empty `BUILD` file in the root directory to mark it as
    // a package and call the extensions
    writeToFile(vars.depsBuildFile, "")

    // make tree of BUILD files
    targets
      .groupBy(_.coordinates.groupId)
      .foreach { (group, targets) =>
        val file = new File(vars.targetsTreeFile, group.toPath + File.separator + vars.targetsFileName)
        val content = vars.targetsHeader + targets.map(_.toBzl()).mkString
        writeToFile(file, content)
      }
