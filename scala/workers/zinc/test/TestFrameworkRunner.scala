package rules_scala
package workers.zinc.test

import common.sbt_testing.*

import java.io.ObjectOutputStream
import java.nio.file.Path
import sbt.testing.{Event, Framework, Logger}
import scala.collection.mutable

final class BasicTestRunner(framework: Framework, classLoader: ClassLoader, logger: Logger) extends TestFrameworkRunner:
  def execute(tests: Seq[TestDefinition], scopeAndTestName: String, arguments: Seq[String]) =
    var tasksAndEvents = mutable.ListBuffer[(String, mutable.ListBuffer[Event])]()
    ClassLoaders.withContextClassLoader(classLoader) {
      TestHelper.withRunner(framework, scopeAndTestName, classLoader, arguments) { runner =>
        val reporter = TestReporter(logger)
        val tasks = runner.tasks(tests.map(TestHelper.taskDef(_, scopeAndTestName)).toArray)
        reporter.pre(framework, tasks)
        val taskExecutor = TestTaskExecutor(logger)
        val failures = mutable.Set[String]()
        for task <- tasks do
          reporter.preTask(task)
          val events = taskExecutor.execute(task, failures)
          reporter.postTask()
          tasksAndEvents += ((task.taskDef.fullyQualifiedName, events))
        reporter.post(failures.toSeq)
        JUnitXmlReporter(tasksAndEvents).write
        !failures.nonEmpty
      }
    }

final class ClassLoaderTestRunner(framework: Framework, classLoaderProvider: () => ClassLoader, logger: Logger) extends TestFrameworkRunner:
  def execute(tests: Seq[TestDefinition], scopeAndTestName: String, arguments: Seq[String]) =
    var tasksAndEvents = mutable.ListBuffer[(String, mutable.ListBuffer[Event])]()
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
      val classLoader = classLoaderProvider()
      val isolatedFramework = TestFrameworkLoader(classLoader, logger).load(framework.getClass.getName).get
      TestHelper.withRunner(isolatedFramework, scopeAndTestName, classLoader, arguments) { runner =>
        ClassLoaders.withContextClassLoader(classLoader) {
          val tasks = runner.tasks(Array(TestHelper.taskDef(test, scopeAndTestName)))
          for task <- tasks do
            reporter.preTask(task)
            val events = taskExecutor.execute(task, failures)
            reporter.postTask()
            tasksAndEvents += ((task.taskDef.fullyQualifiedName, events))
        }
      }
    }
    reporter.post(failures)
    JUnitXmlReporter(tasksAndEvents).write
    !failures.nonEmpty

final class ProcessCommand(
    val executable: String,
    val arguments: Seq[String]
) extends Serializable

final class ProcessTestRunner(
    framework: Framework,
    classpath: Seq[Path],
    command: ProcessCommand,
    logger: Logger & Serializable
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
