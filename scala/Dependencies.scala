package rules_scala3.scala

import sbt.librarymanagement.syntax.*
import sbt.librarymanagement.{DependencyBuilders, ModuleID, Resolver}, DependencyBuilders.OrganizationArtifactName

object Dependencies:

  private val sbtVersion = "2.0.0-M3"
  val scalapbV = "1.0.0-alpha.1"
  val munitV = "1.1.0"

  val resolvers: Seq[Resolver] = Vector(
    "mavencentral".at("https://repo1.maven.org/maven2/"),
    "sonatype releases".at("https://oss.sonatype.org/service/local/repositories/releases/content"),
    "apache staging".at("https://repository.apache.org/content/repositories/staging"),
    "apache snapshots".at("https://repository.apache.org/snapshots"),
    "google".at("https://maven.google.com/"),
    "jitsi-maven-repository".at("https://github.com/jitsi/jitsi-maven-repository/raw/master/releases")
  )
  val replacements: Map[OrganizationArtifactName, String] = Map(
    "org.scala-lang" % "scala3-library" -> "@scala3_library//jar",
    "org.scala-lang" % "scala-library" -> "@scala_library_2_13//jar",
    "org.scala-lang" % "scala-reflect" -> "@scala_reflect_2_13//jar"
  )
  val dependencies: Seq[ModuleID] = Vector(
    "org.jacoco"            % "org.jacoco.core"       % "0.8.12",
    "org.jline"             % "jline-reader"          % "3.27.1",
    "org.scala-lang.modules" %% "scala-xml"           % "2.3.0",
    "org.scala-sbt"         % "test-interface"        % "1.0",
    "org.scala-sbt"         % "compiler-interface"    % sbtVersion,
    "org.scala-sbt"         % "util-interface"        % sbtVersion,
    "org.scala-sbt"         %% "util-logging"         % sbtVersion,
    "org.scala-sbt"         %% "util-relation"         % sbtVersion,
    "org.scala-sbt"         %% "zinc"                 % sbtVersion,
    "org.scala-sbt"         %% "zinc-core"            % sbtVersion,
    "org.scala-sbt"         %% "zinc-classpath"       % sbtVersion,
    "org.scala-sbt"         %% "zinc-compile-core"    % sbtVersion,
    "org.scala-sbt"         %% "zinc-persist"         % sbtVersion,
    "org.scala-sbt"         %% "zinc-apiinfo"         % sbtVersion,
    "org.scalameta"         %% "munit"                % munitV,
    "org.scalameta"         %% "munit-diff"           % munitV,
  )