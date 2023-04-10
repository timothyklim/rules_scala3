package rules_scala3.deps

import java.io.File

import lmcoursier.*
import sbt.internal.librarymanagement.cross.CrossVersionUtil
import sbt.internal.util.ConsoleLogger
import sbt.librarymanagement.*
import sbt.librarymanagement.Configurations.Component
import sbt.librarymanagement.Resolver.{DefaultMavenRepository, JCenterRepository, JavaNet2Repository}
import sbt.librarymanagement.syntax.*

object Deps:
  def main(args: Array[String]): Unit =
    // https://github.com/coursier/sbt-coursier/blob/3df025313bf010d80b8b9288c76fa6a3cb13c7d0/modules/lm-coursier/src/test/scala/lmcoursier/ResolutionSpec.scala

    lazy val log = ConsoleLogger()

    val lmEngine = CoursierDependencyResolution(CoursierConfiguration().withResolvers(resolvers))

    // val module = "commons-io" % "commons-io" % "2.5"
    // lm.retrieve(module, scalaModuleInfo = None, File("/tmp/target"), log)

    val stubModule = "com.example" % "foo" % "0.1.0" % "compile"
    val dependencies = Vector(
      "com.typesafe.scala-logging" % "scala-logging_2.12" % "3.7.2" % "compile",
      "org.scalatest" % "scalatest_2.12" % "3.0.4" % "test"
    ).map(_.withIsTransitive(false))
    val coursierModule = module(lmEngine, stubModule, dependencies, Some("2.12.4"))
    val resolution =
      lmEngine.update(coursierModule, UpdateConfiguration(), UnresolvedWarningConfiguration(), log)
    val r = resolution.right.get
    println(s"r:$r")
  end main

  def resolvers = Vector(
    DefaultMavenRepository,
    JavaNet2Repository,
    JCenterRepository,
    Resolver.sbtPluginRepo("releases")
  )

  def configurations = Vector(Compile, Test, Runtime, Provided, Optional, Component)

  def module(
      lmEngine: DependencyResolution,
      moduleId: ModuleID,
      deps: Vector[ModuleID],
      scalaFullVersion: Option[String],
      overrideScalaVersion: Boolean = true
    ): ModuleDescriptor =
      val scalaModuleInfo = scalaFullVersion map { fv =>
        ScalaModuleInfo(
          scalaFullVersion = fv,
          scalaBinaryVersion = CrossVersionUtil.binaryScalaVersion(fv),
          configurations = configurations,
          checkExplicit = true,
          filterImplicit = false,
          overrideScalaVersion = overrideScalaVersion
        )
      }

      val moduleSetting = ModuleDescriptorConfiguration(moduleId, ModuleInfo("foo"))
        .withDependencies(deps)
        .withConfigurations(configurations)
        .withScalaModuleInfo(scalaModuleInfo)
      lmEngine.moduleDescriptor(moduleSetting)
