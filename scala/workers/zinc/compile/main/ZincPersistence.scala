package rules_scala
package workers.zinc.compile

import workers.common.FileUtil

import java.nio.file.{Files, Path}

trait ZincPersistence:
  def load(): Unit
  def save(): Unit

final class FilePersistence(cacheDir: Path, analysisStoreFile: Path, jar: Path) extends ZincPersistence:
  private val cacheAnalysisStoreFile = cacheDir.resolve("analysis_store.gz")
  private val cacheJar = cacheDir.resolve("classes.jar")

  /** Existance indicates that files are incomplete.
    */
  private val tmpMarker = cacheDir.resolve(".tmp")

  override def load() =
    if Files.exists(cacheDir) && Files.notExists(tmpMarker) then
      Files.copy(cacheAnalysisStoreFile, analysisStoreFile)
      Files.copy(cacheJar, jar)

  override def save() =
    if Files.exists(cacheDir) then FileUtil.delete(cacheDir)
    Files.createDirectories(cacheDir)
    Files.createFile(tmpMarker)
    Files.copy(analysisStoreFile, cacheAnalysisStoreFile)
    Files.copy(jar, cacheJar)
    Files.deleteIfExists(tmpMarker)

object NullPersistence extends ZincPersistence:
  override def load() = ()
  override def save() = ()
