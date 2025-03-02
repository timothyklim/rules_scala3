package rules_scala
package workers.zinc.compile

import java.math.BigInteger
import java.nio.file.{Files, Path, Paths}
import java.security.MessageDigest

import scala.collection.mutable
import scala.concurrent.{Future, Await, ExecutionContext}
import scala.concurrent.duration.Duration
import scala.concurrent.ExecutionContext.Implicits.global

import sbt.internal.inc.{PlainVirtualFile, Analysis}
import xsbti.compile.PerClasspathEntryLookup

import workers.common.FileUtil

sealed trait Dep:
  def file: Path
  def classpath: Path
final case class LibraryDep(file: Path) extends Dep:
  override def classpath = file
final case class DepAnalysisFiles(analysisStore: Path)
final case class ExternalDep(file: Path, classpath: Path, analysis: DepAnalysisFiles) extends Dep
final case class ExternalCachedDep(cachedPath: Path, file: Path, classpath: Path, analysis: DepAnalysisFiles) extends Dep

object Deps:
  def sha1(file: Path): String =
    val digest = MessageDigest.getInstance("SHA1")
    BigInteger(1, digest.digest(Files.readAllBytes(file))).toString(16)

  def create(depsCache: Option[Path], classpath: collection.Seq[Path], analyses: collection.Map[Path, (Path, DepAnalysisFiles)]): collection.Seq[Dep] =
    val roots = mutable.Set.empty[Path]
    val xs = classpath.flatMap: original =>
      analyses.get(original).fold[Option[Dep]](Some(LibraryDep(original))): (root, analysis) =>
        if roots.add(root) then
          depsCache match
            case Some(cacheRoot) =>
              val cachedPath = cacheRoot.resolve(sha1(original))
              Some(ExternalCachedDep(cachedPath = cachedPath, file = original, classpath = root, analysis))
            case None => Some(ExternalDep(original, root, analysis))
        else None
    val futures = Future.sequence:
      xs.map:
        case dep: LibraryDep => Future.successful(dep)
        case dep: ExternalDep => Future:
          FileUtil.extractZip(dep.file, dep.classpath)
          dep
        case dep: ExternalCachedDep => Future:
          FileUtil.extractZipIdempotently(dep.file, dep.cachedPath)
          Files.createDirectories(dep.classpath.getParent())
          Files.createSymbolicLink(dep.classpath, dep.cachedPath)
          dep
    Await.result(futures, Duration.Inf)

  def used(deps: Iterable[Dep], analysis: Analysis, lookup: PerClasspathEntryLookup)(dep: Dep): Boolean =
    val externalDeps = analysis.relations.allExternalDeps
    val libraryDeps = analysis.relations.allLibraryDeps

    inline def lookupExists(dep: Dep): Boolean =
      val definesClass = lookup.definesClass(absoluteVirtualFile(dep))
      externalDeps.exists(definesClass(_))

    dep match
      case dep: ExternalDep => lookupExists(dep)
      case dep: ExternalCachedDep => lookupExists(dep)
      case dep: LibraryDep => libraryDeps.contains(absoluteVirtualFile(dep))
  end used

  private val root = Paths.get("").toAbsolutePath()

  private def absoluteVirtualFile(dep: Dep): PlainVirtualFile =
    PlainVirtualFile(if dep.file.startsWith(root) then dep.file else root.resolve(dep.file))
