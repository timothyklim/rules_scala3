package higherkindness.rules_scala
package workers.common

import xsbti.compile.ScalaInstance
import sbt.internal.inc.InvalidScalaProvider

import java.io.File
import java.net.URLClassLoader
import java.util.Properties

final class AnnexScalaInstance(val allJars: Array[File]) extends ScalaInstance {
  override def version: String = actualVersion
  override lazy val actualVersion: String = {
    val stream = loader.getResourceAsStream("compiler.properties")
    try {
      val props = new Properties
      props.load(stream)
      props.getProperty("version.number")
    } finally stream.close()
  }

  override val compilerJar: File = allJars
    .collectFirst { case jar if AnnexScalaInstance.CompilerRegEx.findFirstMatchIn(jar.getName).nonEmpty => jar }
    .getOrElse(throw new InvalidScalaProvider(s"Couldn't find 'scala-compiler.jar'"))

  override lazy val libraryJars: Array[File] = allJars
    .collect { case jar if AnnexScalaInstance.LibraryRegEx.findFirstMatchIn(jar.getName).nonEmpty => jar }

  override def otherJars: Array[File] = allJars.filterNot(f => compilerJar == f || libraryJars.contains(f))

  override lazy val loader: ClassLoader =
    new URLClassLoader(allJars.map(_.toURI.toURL), null)
  override def loaderLibraryOnly: ClassLoader = null
}

object AnnexScalaInstance {
  val CompilerRegEx = """scala3?-compiler.*\.jar""".r
  val LibraryRegEx = """scala3?-library.*\.jar""".r
}
