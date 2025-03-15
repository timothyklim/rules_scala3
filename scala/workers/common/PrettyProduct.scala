package rules_scala3.workers.common

trait PrettyProduct extends Product:
  final override def toString: String =
    this.productElementNames
      .zip(this.productIterator)
      .map((name, value) => s"$name=$value")
      .mkString(this.productPrefix + "(", ", ", ")")
