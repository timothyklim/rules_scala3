package rules_scala
package common.sbt_testing

import sbt.testing.{Event, Fingerprint, Framework, Logger, Runner, Status, Task, TaskDef, TestWildcardSelector}
import scala.collection.mutable
import scala.util.control.NonFatal

final class TestDefinition(val name: String, val fingerprint: Fingerprint & Serializable) extends Serializable

final class TestFrameworkLoader(loader: ClassLoader, logger: Logger):
  def load(className: String) =
    val framework =
      try Some(Class.forName(className, true, loader).getDeclaredConstructor().newInstance())
      catch
        case _: ClassNotFoundException => None
        case NonFatal(e)               => throw Exception(s"Failed to load framework $className", e)
    framework.map {
      case framework: Framework => framework
      case _                    => throw Exception(s"$className does not implement ${classOf[Framework].getName}")
    }

object TestHelper:
  def withRunner[A](framework: Framework, scopeAndTestName: String, classLoader: ClassLoader, arguments: Seq[String])(
      f: Runner => A
  ) =
    val options = Array.empty[String]
    val runner = framework.runner(arguments.toArray, options, classLoader)
    try f(runner)
    finally runner.done()

  def taskDef(test: TestDefinition, scopeAndTestName: String) =
    TaskDef(
      test.name,
      test.fingerprint,
      false,
      Array(TestWildcardSelector(scopeAndTestName.replace("::", " ")))
    )

final class TestReporter(logger: Logger):
  def post(failures: Traversable[String]) =
    if failures.nonEmpty then
      logger.error(s"${failures.size} ${if failures.size == 1 then "failure" else "failures"}:")
      failures.toSeq.sorted.foreach(name => logger.error(s"    $name"))
      logger.error("")

  def postTask() = logger.info("")

  def pre(framework: Framework, tasks: Traversable[Task]) =
    logger.info(s"${framework.getClass.getName}: ${tasks.size} tests")
    logger.info("")

  def preTask(task: Task) = logger.info(task.taskDef.fullyQualifiedName)

final class TestTaskExecutor(logger: Logger):
  def execute(task: Task, failures: mutable.Set[String]): mutable.ListBuffer[Event] =
    var events = mutable.ListBuffer[Event]()
    val pending = mutable.Set.empty[String]

    def execute(task: Task): Unit =
      val name = task.taskDef.fullyQualifiedName
      pending += name
      val tasks = task.execute(
        event =>
          events += event
          event.status match
            case Status.Failure | Status.Error => failures += name
            case _                             => pending -= name
        ,
        Array(PrefixedTestingLogger(logger, "    "))
      )
      if tasks.isEmpty then pending -= name
      else tasks.foreach(execute)

    execute(task)

    for failed <- pending do failures += failed

    events
