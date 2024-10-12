package rules_scala3.deps.src

import sbt.librarymanagement.{ModuleID, ModuleReport}
import java.io.File

enum Language(val asString: String):
  case Scala extends Language("scala")
  case Java extends Language("java")

extension (m: ModuleID)
  def toCoordinates: Coordinates = Coordinates(groupId = m.organization, artifactId = m.name, version = m.revision)
  def toUvCoordinates: Coordinates = Coordinates(groupId = m.organization, artifactId = m.name)
  def language: Language =
    if "_[23]".r.findFirstIn(m.name).isDefined || m.organization == "org.scala-lang"
    then Language.Scala
    else Language.Java
  def cleanName: String =
    val scalaNameVersion = """^(.*)_([23](?:\.\d{1,2})?(?:[\.-].*)?)$""".r
    m.name match
      case scalaNameVersion(n, _) => n
      case _                      => m.name

extension (m: ModuleReport)
  def filterCallers(replacements: Map[Coordinates, String]): ModuleReport =
    m.withCallers(m.callers.filterNot(caller => replacements.contains(caller.caller.toUvCoordinates.withCleanName)))
