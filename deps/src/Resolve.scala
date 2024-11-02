package rules_scala3.deps.src

import lmcoursier.{CoursierConfiguration, CoursierDependencyResolution}
import sbt.internal.util.ConsoleLogger
import sbt.librarymanagement.syntax.*
import sbt.librarymanagement.{Configurations, ScalaModuleInfo, UnresolvedWarningConfiguration, UpdateConfiguration}
import sbt.internal.librarymanagement.cross.CrossVersionUtil
import scala.collection.mutable.HashMap

object Resolve:
  def apply()(using vars: Vars, cfg: DepsCfg): Vector[Target] =
    val csConfig = CoursierConfiguration()
      .withClasspathOrder(false) // it just gets in the way and creates duplicates.
      .withResolvers(cfg.getResolvers)

    val scalaModuleInfo = ScalaModuleInfo(
      scalaFullVersion = vars.scalaVersion,
      scalaBinaryVersion = CrossVersionUtil.binaryScalaVersion(vars.scalaVersion),
      configurations = Configurations.default,
      // https://github.com/sbt/librarymanagement/blob/develop/ivy/src/main/scala/sbt/internal/librarymanagement/IvyScalaUtil.scala
      checkExplicit = true,
      filterImplicit = true,
      overrideScalaVersion = true
    )

    val lmEngine = CoursierDependencyResolution(csConfig)

    val resolution = lmEngine.update(
      module = lmEngine.moduleDescriptor("com.example" % "foo" % "0.1.0", cfg.getDependencies, Some(scalaModuleInfo)),
      configuration = UpdateConfiguration(),
      uwconfig = UnresolvedWarningConfiguration(),
      log = ConsoleLogger()
    )
    // convert librarymanagement modules to our targets
    resolution match
      case Left(e) => throw e.resolveException
      case Right(resolution) =>
        val modules = resolution.configurations.head.modules
          // filter out dependencies of replacement
          .map(_.filterCallers(cfg.getReplacements))
          .filterNot { moduleReport =>
            moduleReport.callers.isEmpty && !cfg.getDependencies
              .map(_.toUvCoordinates.withCleanName)
              .contains(moduleReport.module.toUvCoordinates.withCleanName)
          }
        val uvCoordinates_modules = modules.map { m => m.module.toUvCoordinates -> m.module }.toMap
        val modules_deps: HashMap[Coordinates, Vector[Coordinates]] = HashMap.empty
        modules.foreach { moduleReport =>
          moduleReport.callers.foreach { caller =>
            // dependency can be resolved with a different version,
            // so the comparison is done by org-name pair.
            val uvCaller = caller.caller.toUvCoordinates
            val coordinates = uvCoordinates_modules.get(uvCaller) match
              case Some(m) => m.toCoordinates
              case None => sys.error(s"""The organization-name pair was not found in the resolved modules.
                                        |${uvCaller.toString} is missing.""".stripMargin)
            if modules_deps.contains(coordinates)
            then modules_deps(coordinates) = modules_deps(coordinates) :+ moduleReport.module.toCoordinates
            else modules_deps += (coordinates -> Vector(moduleReport.module.toCoordinates))
          }
        }
        modules
          .map { moduleReport =>
            Target(
              moduleReport = moduleReport,
              replacement_label = cfg.getReplacements.get(moduleReport.module.toUvCoordinates.withCleanName),
              isDirect = cfg.getDependencies.map(_.cleanName).contains(moduleReport.module.cleanName),
              module_deps = modules_deps.toMap.getOrElse(moduleReport.module.toCoordinates, Vector.empty).sortBy(_.toString)
            )
          }
          .distinctBy(t => (t.coordinates, t.lang))
          .sortBy(_.name)
