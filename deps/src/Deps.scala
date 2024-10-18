package rules_scala3.deps.src

import sbt.librarymanagement.syntax.*
import sbt.librarymanagement.{DependencyBuilders, ModuleID, Resolver}, DependencyBuilders.OrganizationArtifactName
import scala.util.Try
import scala.reflect.runtime.universe._

object Deps:
  def main(args: Array[String]): Unit =
    given Vars = Vars(args.toIndexedSeq).getOrElse(sys.exit(2))

    val dependenciesClassName = summon[Vars].dependencies
    val dependenciesClass = getDependenciesClass(name = dependenciesClassName)

    val resolversField = dependenciesClass.getMethod("resolvers").invoke(null).asInstanceOf[Vector[Resolver]]
    val replacementsField = dependenciesClass.getMethod("replacements").invoke(null).asInstanceOf[Map[OrganizationArtifactName, String]]
    val dependenciesField = dependenciesClass.getMethod("dependencies").invoke(null).asInstanceOf[Vector[ModuleID]]

    given DepsCfg = DepsCfg(
      resolvers = resolversField,
      replacements = replacementsField,
      dependencies = dependenciesField
    )

    MakeTree()

  private def getDependenciesClass(name: String) =
    val dependenciesClass = Try(Class.forName(name)) match
      case scala.util.Success(clazz) => clazz
      case scala.util.Failure(e) =>
        throw new ClassNotFoundException(s"Failed to load Dependencies class: ${e.getMessage}", e)
    dependenciesClass
