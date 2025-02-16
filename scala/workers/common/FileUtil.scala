package rules_scala
package workers.common

import java.io.{IOException, File}
import java.nio.channels.{FileChannel, FileLock}
import java.nio.file.{FileAlreadyExistsException, FileVisitResult, Files, OpenOption, Path, SimpleFileVisitor, StandardCopyOption, StandardOpenOption}
import java.nio.file.attribute.BasicFileAttributes
import java.security.SecureRandom
import java.util.zip.{ZipEntry, ZipInputStream, ZipOutputStream}

import scala.annotation.tailrec

class CopyFileVisitor(source: Path, target: Path) extends SimpleFileVisitor[Path]:
  override def preVisitDirectory(directory: Path, attributes: BasicFileAttributes) =
    try Files.createDirectory(target.resolve(source.relativize(directory)))
    catch case _: FileAlreadyExistsException => ()
    FileVisitResult.CONTINUE

  override def visitFile(file: Path, attributes: BasicFileAttributes) =
    Files.copy(file, target.resolve(source.relativize(file)), StandardCopyOption.COPY_ATTRIBUTES)
    FileVisitResult.CONTINUE

final class DeleteFileVisitor extends SimpleFileVisitor[Path]:
  override def postVisitDirectory(directory: Path, error: IOException) =
    Files.deleteIfExists(directory)
    FileVisitResult.CONTINUE

  override def visitFile(file: Path, attributes: BasicFileAttributes) =
    Files.deleteIfExists(file)
    FileVisitResult.CONTINUE

final class ZipFileVisitor(root: Path, zip: ZipOutputStream) extends SimpleFileVisitor[Path]:
  override def visitFile(file: Path, attributes: BasicFileAttributes) =
    val entry = ZipEntry(root.relativize(file).toString())
    zip.putNextEntry(entry)
    Files.copy(file, zip)
    zip.closeEntry()
    FileVisitResult.CONTINUE

object FileUtil:

  def copy(source: Path, target: Path) = Files.walkFileTree(source, CopyFileVisitor(source, target))

  def delete(path: Path) = Files.walkFileTree(path, new DeleteFileVisitor)

  def createZip(input: Path, archive: Path) =
    val zip = ZipOutputStream(Files.newOutputStream(archive))
    try Files.walkFileTree(input, ZipFileVisitor(input, zip))
    finally zip.close()

  private def lock[A](lockFile: Path)(f: => A): A =
    Files.createDirectories(lockFile.getParent)
    try Files.createFile(lockFile)
    catch case _: FileAlreadyExistsException => ()
    val channel = FileChannel.open(lockFile, StandardOpenOption.WRITE)

    @tailrec def tryLock(): FileLock = channel.tryLock() match
      case lock: FileLock => lock
      case null =>
        Thread.sleep(100)
        tryLock()

    try
      val lock = tryLock()
      try f
      finally lock.release()
    finally channel.close()

  /** We call `extractZipIdempotentally` in `Deps` to avoid a potential race condition. `extractZipIdempotentally` guarantees that the zip file will
    * be extracted completely once and only once. If we didn't do this, we would either perform the work every time, mitigating the advatnages of the
    * extracted dependencies cache, or face a race condition.
    *
    * The race condition occurs if projects B and C depend on project A; both B and C could begin almost simulatenously. Extracting a zip is not
    * atomic. If B begins extracting first, and C simply checks if the output directory exists, it could begin compiling while B is still extracting
    * the dependency. Alternatives to pessimistic locking include extracting to arbitrary temporary destinations then atomically moving in place, but
    * that presents some other challenges.
    */
  def extractZipIdempotently(archive: Path, output: Path): Unit =
    lock(output.getParent.resolve(s".${output.getFileName}.lock")) {
      if !Files.exists(output) then extractZip(archive, output)
    }

  def extractZip(archive: Path, output: Path) =
    val fileStream = Files.newInputStream(archive)
    try
      val zipStream = ZipInputStream(fileStream)

      @tailrec def next(files: List[File]): List[File] =
        zipStream.getNextEntry match
          case null => files
          case entry: ZipEntry =>
            if entry.isDirectory then
              zipStream.closeEntry()
              next(files)
            else
              val file = output.resolve(entry.getName)
              Files.createDirectories(file.getParent)
              Files.copy(zipStream, file, StandardCopyOption.REPLACE_EXISTING)
              zipStream.closeEntry()
              next(file.toFile :: files)

      next(Nil)
    finally fileStream.close()
