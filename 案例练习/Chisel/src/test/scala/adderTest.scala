

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class addTester extends AnyFlatSpec with ChiselScalatestTester {

  "Add" should "work" in {
    test(new adder) { dut =>
      for (a <- 0 to 2) {
        for (b <- 0 to 3) {
          val result = a + b
          dut.io.a.poke(a.U)
          dut.io.b.poke(b.U)
          dut.clock.step(1)
          dut.io.c.expect(result.U)
        }
      }
    }
  }
}
