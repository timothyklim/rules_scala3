package higherkindness.rules_scala
package workers.common

import xsbti.compile.ScalaInstance
import sbt.internal.inc.InvalidScalaProvider

import java.io.File
import java.net.URLClassLoader
import java.util.Properties
import scala.util.matching.Regex

final class AnnexScalaInstance(
  override val allJars: Array[File],
  topLoader: ClassLoader = ClassLoader.getSystemClassLoader
) extends ScalaInstance {
  import AnnexScalaInstance._

  override lazy val version: String = actualVersion
  override lazy val actualVersion: String = {
    val stream = loader.getResourceAsStream("compiler.properties")
    try {
      val props = new Properties
      props.load(stream)
      props.getProperty("version.number")
    } finally stream.close()
  }

  override val compilerJar: File = allJars
    .collectFirst { case jar if isCompiler(jar) => jar }
    .getOrElse(throw new InvalidScalaProvider(s"Couldn't find 'scala-compiler.jar'"))
  override val compilerJars = Array(compilerJar)

  override val libraryJars: Array[File] = allJars
    .collect { case jar if isLibraryJar(jar) => jar }
    .distinct

  override def otherJars: Array[File] =
    allJars.filterNot(f => compilerJars.contains(f) || libraryJars.contains(f)).distinct

  override lazy val loaderLibraryOnly: ClassLoader =
    new URLClassLoader(libraryJars.map(_.toURI.toURL), topLoader)
  override lazy val loaderCompilerOnly: ClassLoader =
    new URLClassLoader(compilerJars.map(_.toURI.toURL), loaderLibraryOnly)
  override lazy val loader: ClassLoader =
    new URLClassLoader(allJars.map(_.toURI.toURL), loaderLibraryOnly)
}

object AnnexScalaInstance {
  def isCompiler(file: File): Boolean = check(CompilerRE, file)
  def isLibraryJar(file: File): Boolean = check(LibraryRE, file)

  private def check(re: Regex, file: File): Boolean = re.findFirstIn(file.getName()).nonEmpty
  
  private val CompilerRE = """scala3?-compiler.*\.jar""".r
  private val LibraryRE = """scala3?-library.*\.jar""".r
}
