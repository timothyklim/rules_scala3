package deps.src.main

import sbt.librarymanagement.{DependencyBuilders, ModuleID, Resolver}, DependencyBuilders.OrganizationArtifactName
import sbt.librarymanagement.syntax.*

case class DepsCfg private (
    resolvers: Vector[Resolver],
    replacements: Map[OrganizationArtifactName, String],
    dependencies: Vector[ModuleID],
    targetsHeader: String
):
  def getResolvers: Vector[Resolver] = resolvers
  def getReplacements: Map[Coordinates, String] = replacements.map((k, v) => (k % "0.1.0").toUvCoordinates.withCleanName -> v)
  def getDependencies: Vector[ModuleID] = dependencies

object DepsCfg:
  def apply(
      resolvers: Vector[Resolver] = Resolver.defaults,
      replacements: Map[OrganizationArtifactName, String] = Map.empty,
      dependencies: Vector[ModuleID] = Vector.empty,
      targetsHeader: String = """load("@rules_scala3//rules:scala.bzl", "scala_import")"""
  ): DepsCfg = new DepsCfg(resolvers, replacements, dependencies, targetsHeader)
