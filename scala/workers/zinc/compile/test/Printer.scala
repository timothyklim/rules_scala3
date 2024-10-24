package munit.diff

trait Printer {
  def print(value: _root_.scala.Any, out: _root_.scala.StringBuilder, indent: _root_.scala.Int): _root_.scala.Boolean

  def height: _root_.scala.Int

  def isMultiline(string: _root_.scala.Predef.String): _root_.scala.Boolean

  def orElse(other: _root_.munit.diff.Printer): _root_.munit.diff.Printer
}

object Printer {
  val defaultHeight: _root_.scala.Int = ???

  def apply(height: _root_.scala.Int)(partialPrint: _root_.scala.PartialFunction[_root_.scala.Any, _root_.scala.Predef.String]): _root_.munit.diff.Printer = ???

  def apply(partialPrint: _root_.scala.PartialFunction[_root_.scala.Any, _root_.scala.Predef.String]): _root_.munit.diff.Printer = ???
}