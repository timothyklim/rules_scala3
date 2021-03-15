package rules_scala
package workers.common

import xsbti.{Logger, Problem}
import sbt.internal.inc.{LoggedReporter as SbtLoggedReporter}
import sbt.util.InterfaceUtil

import scala.jdk.OptionConverters.*

final class LoggedReporter(logger: Logger) extends SbtLoggedReporter(0, logger):
  import LoggedReporter.pretty

  override protected def logError(problem: Problem): Unit = logger.error(() => Color.Error(pretty(problem)))
  override protected def logInfo(problem: Problem): Unit = logger.info(() => Color.Info(pretty(problem)))
  override protected def logWarning(problem: Problem): Unit = logger.warn(() => Color.Warning(pretty(problem)))
object LoggedReporter:
  def pretty(p: Problem): String = p.rendered.toScala.getOrElse(pretty0(p))

  private def pretty0(p: Problem): String =
    import p.{position as pos}
    pos.sourcePath.map(_.toString).toScala.orElse(pos.sourceFile.toScala.map(_.toString)) match
      case Some(path) =>
        val line = pos.line.toScala.fold("")(l => s":$l")
        val pointer = pos.pointer.toScala.fold("")(p => s":$p")
        val arrow = pos.pointerSpace.toScala.fold("")(s => s"\n$Prefix$s^")
        s"$path$line$pointer ${p.message}\n$Prefix${pos.lineContent}$arrow"
      case _ => p.message
  private val Prefix = "  "
