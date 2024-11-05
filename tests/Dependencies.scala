package tests

import sbt.librarymanagement.syntax.*
import sbt.librarymanagement.{DependencyBuilders, ModuleID, Resolver}, DependencyBuilders.OrganizationArtifactName

object Dependencies:

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
    "com.chuusai"            % "shapeless_2.13"             % "2.4.0-M1",
    "com.google.android"     % "annotations"                % "4.1.1.4",
    "com.google.api.grpc"    % "proto-google-common-protos" % "2.41.0",
    "com.google.code.findbugs" % "jsr305"                   % "3.0.2",
    "com.google.code.gson"   % "gson"                       % "2.10.1",
    "com.google.errorprone"  % "error_prone_annotations"    % "2.28.0",
    "com.google.guava"       % "guava"                      % "32.0.1-android",
    "com.google.protobuf"    % "protobuf-java"              % "4.28.3",
    "com.thesamet.scalapb"   %% "protobuf-runtime-scala_sjs1" % "0.8.16",
    "com.thesamet.scalapb"   %% "scalapb-runtime"           % "0.11.13",
    "com.thesamet.scalapb"   %% "scalapb-runtime-grpc"      % "0.11.13",
    "com.thesamet.scalapb"   %% "scalapb-runtime_sjs1"      % "0.11.13",
    "io.grpc"                % "grpc-api"                   % "1.68.0",
    "io.grpc"                % "grpc-protobuf"              % "1.68.0",
    "io.grpc"                % "grpc-stub"                  % "1.68.0",
    "io.netty"               % "netty-codec-http2"          % "4.1.110.Final",
    "io.netty"               % "netty-handler-proxy"        % "4.1.110.Final",
    "io.netty"               % "netty-transport-native-unix-common" % "4.1.110.Final",
    "io.perfmark"            % "perfmark-api"               % "0.27.0",
    "junit"                  % "junit"                      % "4.13.2",
    "org.checkerframework"   % "checker-qual"               % "3.42.0",
    "org.codehaus.mojo"      % "animal-sniffer-annotations" % "1.24",
    "org.hamcrest"           % "hamcrest-core"              % "1.3",
    "org.scala-lang"         %% "scala3-library"            % "3.5.2",
    "org.scala-lang"         %% "scala3-library_sjs1"       % "3.3.0",
    "org.scala-lang"         % "scala-library"              % "2.13.15",
    "org.scala-lang"         % "scala-reflect"              % "2.13.15",
    "org.scala-lang.modules" %% "scala-collection-compat"   % "2.9.0",
    "org.scala-lang.modules" %% "scala-collection-compat_sjs1" % "2.9.0",
    "org.scala-lang.modules" %% "scala-xml"                 % "2.3.0",
    "org.scala-js"           %% "scalajs-dom_sjs1"          % "2.1.0",
    "org.scala-js"           % "scalajs-library_2.13"       % "1.13.1",
    "org.scala-sbt"          % "test-interface"             % "1.0",
    "org.scala-sbt"          % "util-interface"             % "2.0.0-M2",
    "org.scala-sbt"          %% "util-logging"               % "2.0.0-M2",
    "org.scala-sbt"          %% "zinc-compile-core"         % "2.0.0-M1",
    "org.scalacheck"         %% "scalacheck"                % "1.18.1",
    "org.scalameta"          % "junit-interface"            % "1.0.0",
    "org.scalameta"          %% "munit"                     % "1.0.0",
    "org.scalameta"          %% "munit-scalacheck"          % "1.0.0",
    "org.typelevel"          % "kind-projector_2.13.1"     % "0.13.3",
  )
