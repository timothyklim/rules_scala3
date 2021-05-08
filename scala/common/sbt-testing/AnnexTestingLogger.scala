package rules_scala.common.sbt_testing

import sbt.testing.Logger

enum Verbosity:
  case HIGH, MEDIUM, LOW

final class AnnexTestingLogger(color: Boolean, verbosity: Verbosity) extends Logger with Serializable:
  override def ansiCodesSupported: Boolean = color

  override def error(msg: String): Unit = println(s"$msg")

  override def warn(msg: String): Unit = println(s"$msg")

  override def info(msg: String): Unit =
    verbosity match
      case Verbosity.HIGH | Verbosity.MEDIUM => println(s"$msg")
      case _                                 =>

  override def debug(msg: String): Unit =
    verbosity match
      case Verbosity.HIGH => println(s"$msg")
      case _              =>

  override def trace(err: Throwable): Unit = println(s"${err.getMessage}")
