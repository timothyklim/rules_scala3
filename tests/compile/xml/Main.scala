import scala.xml.{Elem, Text, Null, TopScope}

object Main:
  def main(args: Array[String]): Unit =
    val xml: Elem = Elem(
      null, "things", Null, TopScope, true,
      // Directly pass each Elem as a separate argument
      Elem(null, "thing1", Null, TopScope, true, Text("")),
      Elem(null, "thing2", Null, TopScope, true, Text(""))
    )

    val xmlString = xml.toString()
    println(xmlString)
