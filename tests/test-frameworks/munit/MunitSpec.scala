import munit.{FunSuite, ScalaCheckSuite}
import org.scalacheck.Gen
import org.scalacheck.Prop.forAll

final class MunitSpec extends FunSuite with ScalaCheckSuite:
  property("scalacheck") {
    forAll(Gen.posNum[Int]) { num =>
      assertEquals(num, num)
    }
  }
