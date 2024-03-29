package rules_scala
package workers.zinc.test

import java.io.ObjectOutputStream
import java.nio.file.Path

import scala.collection.mutable
import scala.concurrent.{Await, ExecutionContext, Future}
import scala.concurrent.duration.Duration
import scala.concurrent.ExecutionContext.Implicits.global

import sbt.testing.{Event, Framework, Logger, Task}

import common.sbt_testing.*

final case class FinishedTask(name: String, events: collection.Seq[Event], failures: collection.Set[String])

final class BasicTestRunner(framework: Framework, classLoader: ClassLoader, parallel: Boolean, parallelN: Int, logger: Logger) extends TestFrameworkRunner:
  def execute(tests: Seq[TestDefinition], scopeAndTestName: String, arguments: Seq[String]) =
    ClassLoaders.withContextClassLoader(classLoader) {
      TestHelper.withRunner(framework, scopeAndTestName, classLoader, arguments) { runner =>
        given reporter: TestReporter = TestReporter(logger)
        val tasks = runner.tasks(tests.map(TestHelper.taskDef(_, scopeAndTestName)).toArray)
        reporter.pre(framework, tasks)
        given taskExecutor: TestTaskExecutor = TestTaskExecutor(logger)

        val (tasksAndEvents, failures) = TestFrameworkRunner.run(tasks, parallel = parallel, parallelN = parallelN)
        TestFrameworkRunner.report(tasksAndEvents, failures)
      }
    }

final class ClassLoaderTestRunner(framework: Framework, classLoaderProvider: () => ClassLoader, parallel: Boolean, parallelN: Int, logger: Logger)
    extends TestFrameworkRunner:
  def execute(tests: Seq[TestDefinition], scopeAndTestName: String, arguments: Seq[String]) =
    given reporter: TestReporter = TestReporter(logger)

    val classLoader = framework.getClass.getClassLoader
    ClassLoaders.withContextClassLoader(classLoader) {
      TestHelper.withRunner(framework, scopeAndTestName, classLoader, arguments) { runner =>
        val tasks = runner.tasks(tests.map(TestHelper.taskDef(_, scopeAndTestName)).toArray)
        reporter.pre(framework, tasks)
      }
    }

    given taskExecutor: TestTaskExecutor = TestTaskExecutor(logger)
    val totalTasksAndEvents = mutable.ListBuffer[(String, collection.Seq[Event])]()
    val totalFailures = mutable.Set[String]()

    for test <- tests do
      val classLoader = classLoaderProvider()
      val isolatedFramework = TestFrameworkLoader(classLoader).load(framework.getClass.getName).get
      TestHelper.withRunner(isolatedFramework, scopeAndTestName, classLoader, arguments) { runner =>
        ClassLoaders.withContextClassLoader(classLoader) {
          val tasks = runner.tasks(Array(TestHelper.taskDef(test, scopeAndTestName)))
          val (tasksAndEvents, failures) = TestFrameworkRunner.run(tasks, parallel = parallel, parallelN = parallelN)
          totalTasksAndEvents ++= tasksAndEvents
          totalFailures ++= failures
        }
      }

    TestFrameworkRunner.report(totalTasksAndEvents, totalFailures)

final case class ProcessCommand(executable: String, arguments: Seq[String])

final class ProcessTestRunner(
    framework: Framework,
    classpath: Seq[Path],
    command: ProcessCommand,
    logger: Logger
) extends TestFrameworkRunner:
  def execute(tests: Seq[TestDefinition], scopeAndTestName: String, arguments: Seq[String]) =
    val reporter = TestReporter(logger)

    val classLoader = framework.getClass.getClassLoader
    ClassLoaders.withContextClassLoader(classLoader) {
      TestHelper.withRunner(framework, scopeAndTestName, classLoader, arguments) { runner =>
        val tasks = runner.tasks(tests.map(TestHelper.taskDef(_, scopeAndTestName)).toArray)
        reporter.pre(framework, tasks)
      }
    }

    val taskExecutor = TestTaskExecutor(logger)
    val failures = mutable.Set[String]()
    tests.foreach { test =>
      val process = ProcessBuilder((command.executable +: command.arguments)*)
        .redirectError(ProcessBuilder.Redirect.INHERIT)
        .redirectOutput(ProcessBuilder.Redirect.INHERIT)
        .start()
      try
        val request = TestRequest(
          framework.getClass.getName,
          test,
          scopeAndTestName,
          classpath.map(_.toString),
          logger,
          arguments
        )
        val out = ObjectOutputStream(process.getOutputStream)
        try out.writeObject(request)
        finally out.close()

        if process.waitFor() != 0 then failures += test.name
      finally process.destroy
    }
    reporter.post(failures.toSeq)
    !failures.nonEmpty

sealed trait TestFrameworkRunner:
  def execute(tests: Seq[TestDefinition], scopeAndTestName: String, arguments: Seq[String]): Boolean

object TestFrameworkRunner:
  def run(tasks: collection.Seq[Task], parallel: Boolean, parallelN: Int)(
      using taskExecutor: TestTaskExecutor,
      reporter: TestReporter
  ): (mutable.ListBuffer[(String, collection.Seq[Event])], collection.Set[String]) =
    val finishedTasks =
      if parallel then
        val fut = Future.traverse(tasks.grouped(parallelN)): xs =>
          Future.sequence(xs.map(t => Future(runTask(t))))
        Await.result(fut, Duration.Inf).flatten
      else tasks.map(runTask(_))

    val failures = mutable.Set.empty[String]
    var tasksAndEvents = mutable.ListBuffer[(String, collection.Seq[Event])]()
    for task <- finishedTasks do
      failures ++= task.failures
      tasksAndEvents += ((task.name, task.events))

    (tasksAndEvents, failures)
  end run

  def report(tasksAndEvents: mutable.ListBuffer[(String, collection.Seq[Event])], failures: collection.Set[String])(
      using reporter: TestReporter
  ): Boolean =
    reporter.post(failures)
    JUnitXmlReporter(tasksAndEvents).write
    !failures.nonEmpty

  private def runTask(task: Task)(using taskExecutor: TestTaskExecutor, reporter: TestReporter): FinishedTask =
    reporter.preTask(task)
    val failures = mutable.Set[String]()
    val events = taskExecutor.execute(task, failures)
    reporter.postTask()
    FinishedTask(name = task.taskDef.fullyQualifiedName, events, failures)
