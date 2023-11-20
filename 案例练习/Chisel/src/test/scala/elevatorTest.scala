

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class elevatorTest extends AnyFlatSpec with ChiselScalatestTester {

  "elevator" should "work" in {
    test(new elevator) { dut =>

    }
  }
}
