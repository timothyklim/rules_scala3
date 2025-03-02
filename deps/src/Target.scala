package rules_scala3.deps.src

import sbt.librarymanagement.{Artifact, ModuleID, ModuleReport}

final case class Target(
    coordinates: Coordinates,
    replacement_label: Option[String],
    lang: Language,
    name: String,
    visibility: Target.Visibility,
    actual: String,
    bind: String,
    jar: String,
    url: String,
    deps: Vector[Coordinates]
):
  def toBzl(duplicateCoordinates: Set[Coordinates] = Set.empty)(using vars: Vars): String =

    def getAdjustedName(coordinates: Coordinates): String =
      if duplicateCoordinates.contains(coordinates)
      then coordinates.artifactId.replaceAll("[-.]", "_")
      else coordinates.cleanName

    replacement_label match
      case Some(replacement_label) =>
        s"""\nscala_import(
           |    name = "${coordinates.cleanName}",
           |    exports = [
           |        "$replacement_label"
           |    ],
           |    visibility = [
           |        "${visibility.asString}"
           |    ]
           |)\n""".stripMargin
      case None =>
        val adjustedName = getAdjustedName(coordinates)
        val runtime_deps =
          val deps0 = deps
            .groupBy(getAdjustedName)
            .valuesIterator
            .map(_.head)
            .map { c =>
              val depName = getAdjustedName(c)
              if coordinates.groupId == c.groupId
              then s"\":$depName\""
              else s"\"${vars.targetsTreeBazelPath}/${c.groupId.toUnixPath}:$depName\""
            }
            .toSeq
            .sorted
            .mkString(",\n        ")
          if deps0 == ""
          then ""
          else s"""
                  |    runtime_deps = [
                  |        $deps0
                  |    ],""".stripMargin
        s"""\nscala_import(
           |    name = "$adjustedName",
           |    jars = [
           |        "$jar"
           |    ],$runtime_deps
           |    visibility = [
           |        "${visibility.asString}"
           |    ]
           |)\n""".stripMargin

object Target:
  enum Visibility:
    case Public extends Visibility
    case SubPackages extends Visibility

    def asString(using vars: Vars): String = this match
      case Public      => "//visibility:public"
      case SubPackages => s"${vars.targetsTreeBazelPath}:__subpackages__"

  def apply(
      moduleReport: ModuleReport,
      replacement_label: Option[String],
      isDirect: Boolean,
      module_deps: Vector[Coordinates]
  ): Target =
    val coordinates = moduleReport.module.toCoordinates
    val lang = moduleReport.module.language
    val name: String = s"${coordinates.groupId}_${coordinates.artifactId}".replaceAll("[.\\-]", "_")
    val visibility: Target.Visibility =
      if isDirect
      then Target.Visibility.Public
      else Target.Visibility.SubPackages
    val actual: String = s"@$name//jar"
    val bind: String = s"jar/${coordinates.groupId.toUnixPath}/${coordinates.artifactId}".replaceAll("[.\\-:]", "_")
    val jar: String = s"//external:$bind"
    val url: String =
      def e = sys.error(s"No url in artifact field of ${moduleReport.module.toString}")
      moduleReport.artifacts.head.head.url.fold(e) { u => u.toString } // TODO are you sure there can only be one artifact?

    replacement_label match
      case Some(replacement_label) =>
        Target(
          coordinates = coordinates,
          replacement_label = Some(replacement_label),
          lang = lang,
          name = name,
          visibility = visibility,
          actual = "",
          bind = "",
          jar = "",
          url = "",
          deps = Vector.empty
        )
      case None =>
        Target(
          coordinates = coordinates,
          replacement_label = None,
          lang = lang,
          name = name,
          visibility = visibility,
          actual = actual,
          bind = bind,
          jar = jar,
          url = url,
          deps = module_deps
        )
