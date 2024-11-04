package rules_scala3.deps.src

import java.io.File
import scopt.OParser

case class Vars(
    projectRoot: File = new File("."),
    scalaVersion: String = "",
    dependencies: String = "",
    destination: String = "/3rdparty",
    bazelExtName: String = "workspace.bzl",
    targetsDirName: String = "jvm",
    targetsFileName: String = "BUILD"
):
  def depsFile: File = new File(projectRoot, destination)
  def bazelExtFile: File = new File(depsFile, bazelExtName)
  def depsBuildFile: File = new File(depsFile, targetsFileName)
  def targetsTreeFile: File = new File(depsFile, targetsDirName)
  def targetsTreeBazelPath: String = destination match
    case d if d.startsWith("/") => s"/$d/$targetsDirName"
    case d => s"//$d/$targetsDirName"

object Vars:
  private val builder = OParser.builder[Vars]
  import builder.*

  private val parser = OParser.sequence(
    programName("deps"),
    help('h', "help").text("Prints this usage text"),
    opt[File]('r', "project-root")
      .required()
      .action((value, vars) => {
        val resolvedPath = value.getPath match
          case "." => new File(sys.env.getOrElse("BUILD_WORKSPACE_DIRECTORY", ".")).getAbsoluteFile
          case _ => value.getAbsoluteFile
        vars.copy(projectRoot = resolvedPath)
      })
      .text("The ABSOLUTE path to the root of the bazel repo"),
    opt[String]('s', "scala-version")
      .required()
      .action((value, vars) => vars.copy(scalaVersion = value))
      .text("The version of Scala used in project"),
    opt[String]("dependencies")
      .required()
      .action((value, vars) => vars.copy(dependencies = value))
      .text("The full name of Dependencies.scala class"),
    opt[String]('d', "destination")
      .action((value, vars) => vars.copy(destination = value))
      .text("""The name of the directory that will be created inside your
              |project and will store the generated files.
              |Default: 3rdparty""".stripMargin),
    opt[String]("bazel-extension-name")
      .action((value, vars) => vars.copy(bazelExtName = value))
      .text("""The name of the file to be created in the destination
              |directory that contains the generated bazel rules.
              |Default: workspace.bzl""".stripMargin),
    opt[String]("targets-dir-name")
      .action((value, vars) => vars.copy(targetsDirName = value))
      .text("""The name of the directory to be created in the destianation
              |directory that will contain the dependency tree.
              |Default: jvm""".stripMargin),
    opt[String]("targets-file-name")
      .action((value, vars) => vars.copy(targetsFileName = value))
      .text("""The name of the file that contains the dependency targets.
              |Default: BUILD""".stripMargin)
  )

  def apply(args: Seq[String]): Option[Vars] = OParser.parse(parser, args, Vars())
