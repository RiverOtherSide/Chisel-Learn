

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class adderTest extends AnyFlatSpec with ChiselScalatestTester {

  "Add" should "work" in {
    test(new adder) { dut =>
        dut.io.a.poke(5.U)
        dut.io.b.poke(1.U)
        dut.clock.step(2)
        println(dut.io.c.peek())
//      for (a <- 0 to 2) {
//        for (b <- 0 to 3) {
//          val result = a + b
//          dut.io.a.poke(a.U)
//          dut.io.b.poke(b.U)
//          dut.clock.step(1)
//          dut.io.c.expect(result.U)
//        }
//      }
    }
  }
}
