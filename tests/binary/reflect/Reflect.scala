import scala.reflect.ClassTag

class Item(name: String):
  override def toString: String = s"Item($name)"

object Reflect:

  def main(args: Array[String]): Unit =
    val clazz = summon[ClassTag[Item]].runtimeClass
    val constructor = clazz.getConstructor(classOf[String])
    val itemInstance = constructor.newInstance("example").asInstanceOf[Item]
    println(itemInstance)
