package rules_scala3.deps

import java.io.File

final case class Vars(
    projectRoot: File,
    depsDirName: String,
    bazelExtFileName: String,
    buildFilesDirName: String,
    buildFileName: String,
    scalaVersion: String,
    buildFileHeader: String
):
  def depsFile: File = new File(projectRoot, depsDirName)
  def bazelExtFile: File = new File(depsFile, bazelExtFileName)
  def depsBuildFile: File = new File(depsFile, buildFileName)
  def treeOfBUILDsFile: File = new File(depsFile, buildFilesDirName)
  def treeOfBUILDsBazelPath: String = s"//$depsDirName/$buildFilesDirName"
