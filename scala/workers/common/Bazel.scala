package rules_scala
package workers.common

import java.nio.file.{Files, Paths}

import scala.jdk.CollectionConverters.*

object Bazel:
  val ParamsPrefix = "@"

  def parseParams(args: collection.Seq[String]): collection.Seq[String] = args match
    case collection.Seq(arg) if arg.startsWith(ParamsPrefix) =>
      Files.readAllLines(Paths.get(arg.drop(ParamsPrefix.length))).asScala
    case _ => args
