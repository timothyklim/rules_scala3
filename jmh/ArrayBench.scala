package test

import java.util.concurrent.TimeUnit.*

import org.openjdk.jmh.annotations.*
@State(Scope.Benchmark)
class ArrayState:
  val array = (1 to 100).toArray

  val h = 123

class ArrayBench:
  @Benchmark
  @BenchmarkMode(Array(Mode.SingleShotTime, Mode.Throughput))
  @OutputTimeUnit(MILLISECONDS)
  def testFold(state: ArrayState): Unit =
    val builder = Vector.newBuilder[Int]
    state.array.foldLeft(builder)(_ += _)
    ()

  @Benchmark
  @BenchmarkMode(Array(Mode.SingleShotTime, Mode.Throughput))
  @OutputTimeUnit(MILLISECONDS)
  def testArray(state: ArrayState): Unit =
    val builder = Vector.newBuilder[Int]
    var _i = 0
    while _i < state.array.length do
      builder += state.array(_i)
      _i += 1
    ()

  @Benchmark
  @BenchmarkMode(Array(Mode.SingleShotTime, Mode.Throughput))
  @OutputTimeUnit(MILLISECONDS)
  def testForeach(state: ArrayState): Unit =
    val builder = Vector.newBuilder[Int]
    state.array.foreach(builder += _)
    ()
