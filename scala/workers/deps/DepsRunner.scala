package rules_scala
package workers.deps

import java.io.File
import java.nio.file.{FileAlreadyExistsException, Files, Path, Paths}
import java.util.{Collections, List as JList}

import scala.collection.mutable
import scala.jdk.CollectionConverters.*

import scopt.OParser

import common.worker.WorkerMain

final case class GroupArgument(label: String, jars: Vector[String])
object GroupArgument:
  def from(value: String): GroupArgument = value.split(',') match
    case Array(label, jars @ _*) => GroupArgument(label, jars.toVector)

final case class DepsWorkArguments(
  checkDirect: Boolean = false,
  checkUsed: Boolean = false,
  label: String = "",
  group: Vector[GroupArgument] = Vector.empty,
  direct: Vector[String] = Vector.empty,
  usedWhitelist: Vector[String] = Vector.empty,
  unusedWhitelist: Vector[String] = Vector.empty,
  used: Path = Paths.get("."),
  success: Path = Paths.get("."),
)
object DepsWorkArguments:
  private val builder = OParser.builder[DepsWorkArguments]
  import builder.*

  private val parser = OParser.sequence(
    opt[Boolean]("check_direct").action((check, c) => c.copy(checkDirect = check)),
    opt[Boolean]("check_used").action((check, c) => c.copy(checkUsed = check)),
    opt[String]("label")
      .required()
      .action((l, c) => c.copy(label = l))
      .text("Bazel label"),
    opt[String]("direct")
      .unbounded()
      .optional()
      .action((l, c) => c.copy(direct = c.direct :+ l))
      .text("Labels of direct deps"),
    opt[String]("group")
      .unbounded()
      .optional()
      .action((g, c) => c.copy(group = c.group :+ GroupArgument.from(g)))
      .text("Labels of direct deps"),
    opt[String]("used_whitelist")
      .unbounded()
      .optional()
      .valueName("label")
      .action((l, c) => c.copy(usedWhitelist = c.usedWhitelist :+ l))
      .text("Whitelist of labels to ignore for unused deps"),
    opt[String]("unused_whitelist")
      .unbounded()
      .optional()
      .valueName("label")
      .action((l, c) => c.copy(unusedWhitelist = c.unusedWhitelist :+ l))
      .text("Whitelist of labels to ignore for direct deps"),
    arg[File]("<used>")
      .required()
      .action((f, c) => c.copy(used = f.toPath()))
      .text("Manifest of used"),
    arg[File]("<success>")
      .required()
      .action((f, c) => c.copy(success = f.toPath()))
      .text("Success file"),
  )

  def apply(args: collection.Seq[String]): Option[DepsWorkArguments] =
    OParser.parse(parser, args, DepsWorkArguments())

object DepsRunner extends WorkerMain[Unit]:
  override def init(args: Option[Array[String]]): Unit = ()

  override def work(ctx: Unit, args: Array[String]): Unit =
    val workArgs = DepsWorkArguments(args).getOrElse(throw IllegalArgumentException(s"work args is invalid: ${args.mkString(" ")}"))

    val label = workArgs.label.tail
    val directLabels = workArgs.direct.map(_.tail)
    val (depLabelToPaths, pathToLabel) = workArgs.group match
      case groups if groups.nonEmpty  =>
        val depLabelsMap = new mutable.HashMap[String, collection.Set[String]](initialCapacity = groups.size, loadFactor = 2.0)
        val pathsMap = new mutable.HashMap[String, String](initialCapacity = groups.size, loadFactor = 0.75)

        for (group <- groups) do
          val depLabel = group.label.tail

          depLabelsMap.put(depLabel, group.jars.toSet)

          for (path <- group.jars) pathsMap.put(path, depLabel)

        (depLabelsMap, pathsMap)
      case _ => (EmptyLabelsMap, EmptyPathsMap)
    val usedPaths = Files.readAllLines(workArgs.used).asScala.toSet

    val remove =
      if workArgs.checkUsed then
        val usedWhitelist = workArgs.usedWhitelist.map(_.tail)
        directLabels.diff(usedWhitelist).filterNot(depLabel => depLabelToPaths(depLabel).exists(usedPaths))
      else Nil

    for (depLabel <- remove) do
      println(s"Target '$depLabel' not used, please remove it from the deps.")
      println(s"You can use the following buildozer command:")
      println(s"buildozer 'remove deps $depLabel' $label")

    val add =
      if workArgs.checkDirect then
        val unusedWhitelist = workArgs.unusedWhitelist.map(_.tail)
        usedPaths
          .diff(Set.concat(directLabels, unusedWhitelist).flatMap(depLabelToPaths))
          .flatMap { path =>
            pathToLabel.get(path) match
              case res @ None =>
                System.err.println(s"Warning: There is a reference to $path, but no dependency of $label provides it")
                res
              case res => res
          }
      else Nil
    for (depLabel <- add) do
      println(s"Target '$depLabel' is used but isn't explicitly declared, please add it to the deps.")
      println(s"You can use the following buildozer command:")
      println(s"buildozer 'add deps $depLabel' $label")

    if add.isEmpty && remove.isEmpty then
      try Files.createFile(workArgs.success)
      catch case _: FileAlreadyExistsException => ()

  private val EmptyLabelsMap = Map.empty[String, collection.Set[String]]
  private val EmptyPathsMap = Map.empty[String, String]
