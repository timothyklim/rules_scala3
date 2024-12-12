package rules_scala3

import sbt.librarymanagement.syntax.*
import sbt.librarymanagement.{DependencyBuilders, ModuleID, Resolver}, DependencyBuilders.OrganizationArtifactName

object Dependencies:

  private val jmhV = "1.37"

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
    "org.openjdk.jmh"   % "jmh-core"                 % jmhV,
    "org.openjdk.jmh"   % "jmh-generator-bytecode"   % jmhV,
    "org.openjdk.jmh"   % "jmh-generator-reflection" % jmhV,
    "org.openjdk.jmh"   % "jmh-generator-asm"        % jmhV,
    "com.github.scopt" %% "scopt"                    % "4.1.0",
    "ch.epfl.scala"     % "scalafix-cli_3.5.1"        % "0.13.0",
    "org.scalameta"     % "semanticdb-scalac_2.13.15" % "4.12.0"
  )
