package rules_scala3.deps

import sbt.librarymanagement.{DependencyBuilders, ModuleID}, DependencyBuilders.OrganizationArtifactName
import sbt.librarymanagement.syntax.*
import java.io.{File, FileWriter}

object MakeTree:
  def apply(dependencies: Vector[ModuleID], replacements: Map[OrganizationArtifactName, String]): Unit =
    val targets = Resolve(dependencies, replacements.map((k, v) => (k % "0.1.0").toUvCoordinates.withCleanName -> v))
    val bazelExtContent = BazelExt(targets)
    writeTree(targets, bazelExtContent)

  private def writeToFile(path: File, content: String): Unit =
    val dirname = path.getParentFile
    if !dirname.exists then dirname.mkdirs
    val writer = new FileWriter(path)
    try writer.write(content)
    finally writer.close

  private def writeTree(
      targets: Vector[Target],
      bazelExtContent: String
  ): Unit =
    // create bazel extension file
    writeToFile(vars.bazelExtFile, bazelExtContent)

    // create an empty `BUILD` file in the root directory to mark it as
    // a package and call the extensions
    writeToFile(vars.depsBuildFile, "")

    // make tree of BUILD files
    targets
      .groupBy(_.coordinates.groupId)
      .foreach { (group, targets) =>
        val file = new File(vars.treeOfBUILDsFile, group.toUnixPath + File.separator + vars.buildFileName)
        val content = vars.buildFileHeader + targets.map(_.toBzl).mkString
        writeToFile(file, content)
      }
