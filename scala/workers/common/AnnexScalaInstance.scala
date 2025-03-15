package rules_scala3
package workers.common

import xsbti.compile.ScalaInstance
import sbt.internal.inc.InvalidScalaProvider
import sbt.internal.inc.classpath.ClassLoaderCache

import java.io.File
import java.net.{URL, URLClassLoader}
import java.util.Properties

import scala.util.matching.Regex

final class TopClassLoader(sbtLoader: ClassLoader) extends ClassLoader(null):
  // We can't use the loadClass overload with two arguments because it's
  // protected, but we can do the same by hand (the classloader instance
  // from which we call resolveClass does not matter).
  // The one argument overload of loadClass delegates to this one.
  override protected def loadClass(name: String, resolve: Boolean): Class[?] =
    if name.startsWith("xsbti.") || name.startsWith("org.jline.") then
      val c = sbtLoader.loadClass(name)
      if resolve then resolveClass(c)
      c
    else super.loadClass(name, resolve)

final class AnnexScalaInstance(classLoader: ClassLoader, classLoaderCache: ClassLoaderCache, override val allJars: Array[File]) extends ScalaInstance:
  import AnnexScalaInstance.*

  override lazy val version: String = actualVersion
  override lazy val actualVersion: String =
    val stream = URL(s"jar:file://${compilerJar.getAbsolutePath}!/compiler.properties").openStream()
    try
      val props = Properties()
      props.load(stream)
      props.getProperty("version.number")
    finally stream.close()

  override lazy val compilerJar: File = allJars
    .collectFirst { case jar if isCompiler(jar) => jar }
    .getOrElse(throw InvalidScalaProvider(s"Couldn't find 'scala-compiler.jar'"))
  override lazy val compilerJars = Array(compilerJar)

  override lazy val libraryJars: Array[File] = allJars.filter(isLibraryJar(_)).distinct

  override def otherJars: Array[File] =
    allJars.filterNot(f => compilerJars.contains(f) || libraryJars.contains(f)).distinct

  override lazy val loaderLibraryOnly: ClassLoader = classLoaderCache.cachedCustomClassloader(
    libraryJars.toList,
    () => URLClassLoader(libraryJars.map(_.toURI.toURL), classLoader)
  )
  override lazy val loaderCompilerOnly: ClassLoader = classLoaderCache.cachedCustomClassloader(
    compilerJars.toList,
    () => URLClassLoader(compilerJars.map(_.toURI.toURL), loaderLibraryOnly)
  )
  override lazy val loader: ClassLoader = classLoaderCache.cachedCustomClassloader(
    allJars.toList,
    () => URLClassLoader(allJars.map(_.toURI.toURL), loaderLibraryOnly)
  )

object AnnexScalaInstance:
  def isCompiler(file: File): Boolean = check(CompilerRE, file)
  def isLibraryJar(file: File): Boolean = LibrariesRE.exists(check(_, file))

  private def check(re: Regex, file: File): Boolean = re.findFirstIn(file.getName()).nonEmpty

  private val CompilerRE = """scala3?-compiler.*\.jar""".r
  private val LibrariesRE = Array(
    """scala3?-library.*\.jar""".r,
    """scala3-interfaces.*\.jar""".r,
    """scala-asm.*\.jar""".r,
    """scala-reflect.*\.jar""".r,
    """tasty-core.*\.jar""".r
  )
