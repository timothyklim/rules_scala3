package rules_scala3.workers.common

import scopt.OParser

enum LogLevel:
  case Debug, Error, Info, None, Warn
  val value: String = productPrefix.toLowerCase
object LogLevel:
  def from(value: String): LogLevel = valuesMap(value.toLowerCase)

  given CanEqual[LogLevel, LogLevel] = CanEqual.derived

  private val valuesMap = values.map(v => v.value -> v).toMap
  given scopt.Read[LogLevel] = scopt.Read.reads(from)
