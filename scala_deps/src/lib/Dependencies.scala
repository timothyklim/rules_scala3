package lib

import sbt.librarymanagement.{DependencyBuilders, ModuleID, Resolver}, DependencyBuilders.OrganizationArtifactName
import sbt.librarymanagement.syntax.*

object Dependencies {
  val jmhV = "1.37"

  val resolvers: Vector[Resolver] = Vector(
    "mavencentral".at("https://repo1.maven.org/maven2/"),
    "sonatype releases".at("https://oss.sonatype.org/service/local/repositories/releases/content"),
    "apache staging".at("https://repository.apache.org/content/repositories/staging"),
    "apache snapshots".at("https://repository.apache.org/snapshots"),
    "google".at("https://maven.google.com/"),
    "jitsi-maven-repository".at("https://github.com/jitsi/jitsi-maven-repository/raw/master/releases")
  )

  val replacements: Map[OrganizationArtifactName, String] = Map(
    "org.scala-lang" % "scala3-library" -> "@scala_library_3_3_1//jar",
    "org.scala-lang" % "scala-library" -> "@scala_library_2_13_11//jar",
    "org.scala-lang" % "scala-reflect" -> "@scala_reflect_2_13_11//jar"
  )

  val dependencies: Vector[ModuleID] = Vector(
    "org.openjdk.jmh"   % "jmh-core"                 % jmhV,
    "org.openjdk.jmh"   % "jmh-generator-bytecode"   % jmhV,
    "org.openjdk.jmh"   % "jmh-generator-reflection" % jmhV,
    "org.openjdk.jmh"   % "jmh-generator-asm"        % jmhV,
    "com.github.scopt" %% "scopt"                    % "4.1.0"
  )
}
