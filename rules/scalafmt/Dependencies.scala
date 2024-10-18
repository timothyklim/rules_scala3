package rules_scala3.rules.scalafmt

import sbt.librarymanagement.syntax.*
import sbt.librarymanagement.{DependencyBuilders, ModuleID, Resolver}, DependencyBuilders.OrganizationArtifactName

object Dependencies:

  private val scalafmtV = "3.8.3"
  private val parsersV = "4.10.2"

  val resolvers: Seq[Resolver] = Vector(
    "mavencentral".at("https://repo1.maven.org/maven2/"),
    "sonatype releases".at("https://oss.sonatype.org/service/local/repositories/releases/content"),
    "apache staging".at("https://repository.apache.org/content/repositories/staging"),
    "apache snapshots".at("https://repository.apache.org/snapshots"),
    "google".at("https://maven.google.com/"),
    "jitsi-maven-repository".at("https://github.com/jitsi/jitsi-maven-repository/raw/master/releases")
  )
  // Replacements are not handled by `librarymanagement`. any Scala prefix in the name will be dropped.
  // It also doesn't matter whether you use double `%` to get the Scala version or not.
  val replacements: Map[OrganizationArtifactName, String] = Map(
    "org.scala-lang" % "scala3-library" -> "@scala3_library//jar",
    "org.scala-lang" % "scala-library" -> "@scala_library_2_13//jar",
    "org.scala-lang" % "scala-reflect" -> "@scala_reflect_2_13//jar"
  )
  val dependencies: Seq[ModuleID] = Vector(
    "com.geirsson" % "metaconfig-core_2.13" % "0.12.0",
    "org.scalameta" % "parsers_2.13" % parsersV,
    "org.scalameta" % "trees_2.13" % parsersV,
    "org.scalameta" % "scalafmt-core_2.13" % scalafmtV,
    "org.scalameta" % "scalafmt-sysops_2.13" % scalafmtV,
  )
