

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class elevatorTest extends AnyFlatSpec with ChiselScalatestTester {

  "elevator" should "work" in {
    test(new main) { dut =>
      dut.io.random_up.poke("b0000".U)
      dut.io.random_down.poke("b0000".U)
      dut.io.random.poke(true.B)
      dut.io.r_stop.poke(true.B)
      dut.io.random_push1.poke("b1001".U)
      dut.clock.step(15)
    }
  }
}
