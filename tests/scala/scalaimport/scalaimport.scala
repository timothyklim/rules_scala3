// This is a test for the correctness of scala_import. It intends to import
// 3rdparty dependencies.

import shapeless.*
import scala.xml.XML

object Test:

  type T = Int :: HNil

  def main(args: Array[String]): Unit =
    val xml = XML.loadString("<things><thing1></thing1><thing2></thing2></things>")
    println(xml)
