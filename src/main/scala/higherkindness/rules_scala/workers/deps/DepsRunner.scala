package higherkindness.rules_scala
package workers.deps

import common.args.implicits._
import common.worker.WorkerMain

import java.io.File
import java.nio.file.{FileAlreadyExistsException, Files}
import java.util.{Collections, List => JList}
import net.sourceforge.argparse4j.ArgumentParsers
import net.sourceforge.argparse4j.impl.Arguments
import scala.jdk.CollectionConverters._
import scala.collection.mutable

object DepsRunner extends WorkerMain[Unit] {
  private[this] val argParser = {
    val parser = ArgumentParsers.newFor("deps").addHelp(true).fromFilePrefix("@").build
    parser.addArgument("--check_direct").`type`(Arguments.booleanType)
    parser.addArgument("--check_used").`type`(Arguments.booleanType)
    parser
      .addArgument("--direct")
      .help("Labels of direct deps")
      .metavar("label")
      .nargs("*")
      .setDefault_(Collections.emptyList())
    parser
      .addArgument("--group")
      .action(Arguments.append)
      .help("Label and manifest of jars")
      .metavar("label [path [path ...]]")
      .nargs("+")
    parser.addArgument("--label").help("Label of current target").metavar("label").required(true)
    parser
      .addArgument("--used_whitelist")
      .help("Whitelist of labels to ignore for unused deps")
      .metavar("label")
      .nargs("*")
      .setDefault_(Collections.emptyList)
    parser
      .addArgument("--unused_whitelist")
      .help("Whitelist of labels to ignore for direct deps")
      .metavar("label")
      .nargs("*")
      .setDefault_(Collections.emptyList)
    parser.addArgument("used").help("Manifest of used").`type`(Arguments.fileType.verifyCanRead().verifyIsFile())
    parser.addArgument("success").help("Success file").`type`(Arguments.fileType.verifyCanCreate())
    parser
  }

  override def init(args: Option[Array[String]]): Unit = ()

  override def work(ctx: Unit, args: Array[String]): Unit = {
    val namespace = argParser.parseArgs(args)

    val label = namespace.getString("label").tail
    val directLabels = namespace.getList[String]("direct").asScala.map(_.tail)
    val (depLabelToPaths, pathToLabel) = namespace.getList[JList[String]]("group") match {
      case xs: JList[JList[String]] =>
        val depLabelsMap = new mutable.HashMap[String, collection.Set[String]](initialCapacity = xs.size, loadFactor = 2.0)
        val pathsMap = new mutable.HashMap[String, String](initialCapacity = xs.size, loadFactor = 0.75)

        xs.forEach(_.asScala match {
          case mutable.Buffer(key, xs @ _*) =>
            val depLabel = key.tail

            depLabelsMap.put(depLabel, xs.toSet)

            for (path <- xs) pathsMap.put(path, depLabel)
        })

        (depLabelsMap, pathsMap)
      case _ => (EmptyLabelsMap, EmptyPathsMap)
    }
    val usedPaths = Files.readAllLines(namespace.get[File]("used").toPath).asScala.toSet

    val remove = if (namespace.getBoolean("check_used") == true) {
      val usedWhitelist = namespace.getList[String]("used_whitelist").asScala.map(_.tail)
      directLabels.diff(usedWhitelist).filterNot { depLabel =>
        depLabelToPaths(depLabel).exists(usedPaths)
      }
    } else Nil
    remove.foreach { depLabel =>
      println(s"Target '$depLabel' not used, please remove it from the deps.")
      println(s"You can use the following buildozer command:")
      println(s"buildozer 'remove deps $depLabel' $label")
    }

    val add = if (namespace.getBoolean("check_direct") == true) {
      val unusedWhitelist = namespace.getList[String]("unused_whitelist").asScala.map(_.tail)
      usedPaths
        .diff(Set.concat(directLabels, unusedWhitelist).flatMap(depLabelToPaths))
        .flatMap { path =>
          pathToLabel.get(path) match {
            case res @ None =>
              System.err.println(s"Warning: There is a reference to $path, but no dependency of $label provides it")
              res
            case res => res
          }
        }
    } else Nil
    add.foreach { depLabel =>
      println(s"Target '$depLabel' is used but isn't explicitly declared, please add it to the deps.")
      println(s"You can use the following buildozer command:")
      println(s"buildozer 'add deps $depLabel' $label")
    }

    if (add.isEmpty && remove.isEmpty) {
      try Files.createFile(namespace.get[File]("success").toPath)
      catch { case _: FileAlreadyExistsException => }
    }
  }

  private val EmptyLabelsMap = Map.empty[String, collection.Set[String]]
  private val EmptyPathsMap = Map.empty[String, String]
}
