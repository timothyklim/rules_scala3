package rules_scala3
package workers.common

import xsbti.Logger

import java.io.{PrintWriter, StringWriter}
import java.nio.file.Paths
import java.util.function.Supplier

final class AnnexLogger(level: LogLevel) extends Logger:
  private val root = s"${Paths.get("").toAbsolutePath}/"

  private def format(value: String): String = value.replace(root, "")

  override def debug(msg: Supplier[String]): Unit =
    level match
      case LogLevel.Debug => System.err.println(format(msg.get))
      case _              => ()

  override def error(msg: Supplier[String]): Unit =
    level match
      case LogLevel.Debug | LogLevel.Error | LogLevel.Info | LogLevel.Warn => System.err.println(format(msg.get))
      case _                                                               => ()

  override def info(msg: Supplier[String]): Unit =
    level match
      case LogLevel.Debug | LogLevel.Info => System.err.println(format(msg.get))
      case _                              => ()

  override def trace(err: Supplier[Throwable]): Unit =
    level match
      case LogLevel.Debug | LogLevel.Error | LogLevel.Info | LogLevel.Warn =>
        val trace = StringWriter()
        err.get.printStackTrace(PrintWriter(trace))
        println(format(trace.toString))
      case _ => ()

  override def warn(msg: Supplier[String]): Unit =
    level match
      case LogLevel.Debug | LogLevel.Info | LogLevel.Warn => System.err.println(format(msg.get))
      case _                                              => ()
