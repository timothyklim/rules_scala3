package rules_scala
package common.worker

import java.io.{ByteArrayInputStream, ByteArrayOutputStream, InputStream, PrintStream}
import java.lang.SecurityManager
import java.nio.charset.StandardCharsets.UTF_8
import java.security.Permission

import scala.annotation.tailrec
import scala.util.control.NonFatal

import com.google.devtools.build.lib.worker.WorkerProtocol
import com.google.protobuf.ProtocolStringList

import rules_scala.workers.common.Bazel

final case class ExitTrapped(code: Int) extends Throwable

trait WorkerMain[S]:
  protected def init(args: collection.Seq[String]): S

  protected def work(ctx: S, args: collection.Seq[String]): Unit

  final def main(args: Array[String]): Unit =
    args match
      case Array("--persistent_worker", args*) =>
        val stdin = System.in
        val stdout = System.out
        val stderr = System.err

        System.setSecurityManager(
          new SecurityManager:
            override def checkPermission(permission: Permission): Unit =
              permission.getName match
                case Exit(code) =>
                  stderr.println(s"ScalaCompile worker startup failure: permission=$permission, args=${args.mkString("[", ", ", "]")}")
                  throw ExitTrapped(code.toInt)
                case _ => ()
        )

        val outStream = ByteArrayOutputStream()
        val out = PrintStream(outStream)

        System.setIn(ByteArrayInputStream(Array.emptyByteArray))
        System.setOut(out)
        System.setErr(out)

        @tailrec def process(ctx: S): S =
          val request = WorkerProtocol.WorkRequest.parseDelimitedFrom(stdin)
          val args: Array[String] = request.getArgumentsList() match
            case xs: ProtocolStringList => xs.toArray(Array.empty[String])
            case null                   => Array.empty

          val code =
            try
              work(ctx, args)
              0
            catch
              case ExitTrapped(code) => code
              case NonFatal(e) =>
                e.printStackTrace()
                1

          WorkerProtocol.WorkResponse.newBuilder
            .setOutput(outStream.toString(UTF_8))
            .setExitCode(code)
            .build
            .writeDelimitedTo(stdout)

          out.flush()
          outStream.reset()

          process(ctx)
        end process

        try process(init(Bazel.parseParams(args)))
        finally
          System.setIn(stdin)
          System.setOut(stdout)
          System.setErr(stderr)
      case args => work(init(Array.empty[String]), Bazel.parseParams(args))

  private val Exit = raw"exitVM\.(-?\d+)".r
