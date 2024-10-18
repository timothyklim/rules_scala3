package rules_scala3.rules.scala_proto

import sbt.librarymanagement.syntax.*
import sbt.librarymanagement.{DependencyBuilders, ModuleID, Resolver}, DependencyBuilders.OrganizationArtifactName

object Dependencies:

  private val scalapbV = "1.0.0-alpha.1"
  private val protocBridgeV = "0.9.7"
  private val grpcwebV = "0.7.0"

  val resolvers: Seq[Resolver] = Vector(
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
    "com.thesamet.scalapb"  %% "compilerplugin"        % scalapbV,
    "com.thesamet.scalapb"   % "protoc-bridge_2.13"    % protocBridgeV,
    "com.thesamet.scalapb"   % "protoc-gen_2.13"       % protocBridgeV,
    "com.thesamet.scalapb.grpcweb" %% "scalapb-grpcweb-code-gen" % grpcwebV
  )
