package rules_scala3
package common.worker

import java.io.{ByteArrayInputStream, ByteArrayOutputStream, InputStream, PrintStream}
import java.nio.charset.StandardCharsets.UTF_8
import java.security.Permission

import scala.annotation.tailrec
import scala.util.control.NonFatal

import com.google.devtools.build.lib.worker.WorkerProtocol
import com.google.protobuf.ProtocolStringList

import rules_scala3.workers.common.Bazel

trait WorkerMain[S]:
  protected def init(args: collection.Seq[String]): S

  protected def work(ctx: S, args: collection.Seq[String]): Unit

  final def main(args: Array[String]): Unit =
    args match
      case Array("--persistent_worker", args*) =>
        val stdin = System.in
        val stdout = System.out
        val stderr = System.err

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
              case ex: RuntimeException if (ex.getMessage != null) && ex.getMessage.startsWith(ExitCodePrefix) =>
                ex.getMessage.drop(ExitCodePrefix.length).toInt
              case NonFatal(ex) =>
                ex.printStackTrace()
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

  private val ExitCodePrefix = "System.exit not allowed: "
