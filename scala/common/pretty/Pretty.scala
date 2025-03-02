package rules_scala.common

import java.util.HexFormat

import scala.compiletime.asMatchable

transparent trait Pretty extends Product:

  final override def toString: String =
    this.productElementNames
      .zip(this.productIterator)
      .map { case (name, value) => s"$name=${Pretty(value, shorten = Pretty.isShortened)}" }
      .mkString(this.productPrefix + "(", ", ", ")")

object Pretty:

  def apply[T](p: T, shorten: Boolean): String =
    pprint
      .copy(additionalHandlers = _.asMatchable match
        case b: BigInt => pprint.Tree.Literal(s"0x${b.toString(16)} [len=${b.bitLength / 8L}]")
        case xs: Array[Byte] =>
          val blob = if shorten then preview(HexFormat.of().formatHex(xs.take(32)), size = 64, force = true) else HexFormat.of().formatHex(xs)
          pprint.Tree.Literal(s"0x$blob [len=${xs.length}]")
        case n: Long if !n.isValidInt => pprint.Tree.Literal(s"0x${n.toHexString}L")
        case n: Byte                  => pprint.Tree.Literal((n & 0xff).toString))
      .tokenize(p, width = Int.MaxValue)
      .mkString

  def apply[T](p: T): String = apply[T](p, shorten = true)

  def preview(str: String, size: Int = 256, force: Boolean = false) =
    if str.length <= size then str
    else
      val n = if force then size else str.lastIndexWhere(_.isSpaceChar, size + 1)
      s"${str.take(n).trim}..."

  private val isShortened = System.getProperty("pretty.shorten") != null

trait PrettyProduct extends Product:

  final override def toString: String =
    this.productElementNames
      .zip(this.productIterator)
      .map { case (name, value) => s"$name=$value" }
      .mkString(this.productPrefix + "(", ", ", ")")
