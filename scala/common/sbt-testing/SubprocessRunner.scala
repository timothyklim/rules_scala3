package rules_scala
package common.sbt_testing

import java.io.ObjectInputStream
import java.nio.file.Paths
import scala.collection.mutable

object SubprocessTestRunner:
  def main(args: Array[String]): Unit =
    val input = ObjectInputStream(System.in)
    val request = input.readObject().asInstanceOf[TestRequest]
    val classLoader = ClassLoaders.sbtTestClassLoader(request.classpath.map(path => Paths.get(path).toUri.toURL))

    val loader = TestFrameworkLoader(classLoader, request.logger)
    val framework = loader.load(request.framework).get

    val passed = ClassLoaders.withContextClassLoader(classLoader) {
      TestHelper.withRunner(framework, request.scopeAndTestName, classLoader, request.testArgs) { runner =>
        val tasks = runner.tasks(Array(TestHelper.taskDef(request.test, request.scopeAndTestName)))
        tasks.length == 0 || {
          val reporter = TestReporter(request.logger)
          val taskExecutor = TestTaskExecutor(request.logger)
          val failures = mutable.Set[String]()
          for task <- tasks do
            reporter.preTask(task)
            taskExecutor.execute(task, failures)
            reporter.postTask()
          !failures.nonEmpty
        }
      }
    }

    sys.exit(if passed then 0 else 1)
