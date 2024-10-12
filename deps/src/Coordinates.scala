package rules_scala3.deps.src

import java.io.File
import scala.util.matching.Regex.Groups

case class GroupId(grp: String):
  override def toString: String = grp
  def toUnixPath: String = grp.replaceAll("\\.", "/").replaceAll("-", "_")
  def toPath: String = grp.replaceAll("\\.", File.separator).replaceAll("-", "_")

case class Coordinates(groupId: GroupId, artifactId: String, version: Option[String]):
  override def toString: String = version match
    case Some(v) => s"${groupId}:${artifactId}:${v}"
    case None    => s"${groupId}:${artifactId}"

  def withCleanName: Coordinates = copy(artifactId = this.cleanName)

  def cleanName: String =
    val scalaNameVersion = """^(.*)_([23](?:\.\d{1,2})?(?:[\.-].*)?)$""".r
    def mkName: String = artifactId match
      case scalaNameVersion(n, _) => n
      case _                      => artifactId
    mkName.replaceAll("[.\\-]", "_")

object Coordinates:
  def apply(groupId: String, artifactId: String, version: String): Coordinates =
    Coordinates(GroupId(groupId), artifactId, Some(version))

  def apply(groupId: String, artifactId: String): Coordinates =
    Coordinates(GroupId(groupId), artifactId, None)
