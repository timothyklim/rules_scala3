package higherkindness.rules_scala
package workers.common

import xsbti.{Logger, Problem}
import sbt.internal.inc.{LoggedReporter => SbtLoggedReporter}
import sbt.util.InterfaceUtil

import scala.jdk.OptionConverters._

final class LoggedReporter(logger: Logger) extends SbtLoggedReporter(0, logger) {
  import LoggedReporter.pretty

  override protected def logError(problem: Problem): Unit =
    logger.error(() => problem.rendered.asScala.fold(Color.Error(pretty(problem)))(Color.Error(_)))
  override protected def logInfo(problem: Problem): Unit =
    logger.info(() => problem.rendered.asScala.fold(Color.Info(pretty(problem)))(Color.Info(_)))
  override protected def logWarning(problem: Problem): Unit =
    logger.warn(() => problem.rendered.asScala.fold(Color.Warning(pretty(problem)))(Color.Warning(_)))
}
object LoggedReporter {
  def pretty(p: Problem): String = p.rendered.asScala.getOrElse(pretty0(p))

  private def pretty0(p: Problem): String = {
    import p.{position => pos}
    pos.sourcePath.map(_.toString).asScala.orElse(pos.sourceFile.asScala.map(_.toString)) match {
      case Some(path) =>
        val line = pos.line.asScala.fold("")(l => s":$l")
        val pointer = pos.pointer.asScala.fold("")(p => s":$p")
        val arrow = pos.pointerSpace.asScala.fold("")(s => s"\n$Prefix$s^")
        s"$path$line$pointer ${p.message}\n$Prefix${pos.lineContent}$arrow"
      case _ => p.message
    }
  }
  private val Prefix = "  "
}
