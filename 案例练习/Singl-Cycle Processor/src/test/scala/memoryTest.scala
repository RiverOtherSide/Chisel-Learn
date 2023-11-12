

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class memoryTest extends AnyFlatSpec with ChiselScalatestTester {

  "memory" should "work" in {
    test(new memory) { dut =>
      dut.io.a.poke(1.U)
      dut.clock.step(1)
      println(dut.io.rd.peek())

      dut.io.a.poke(1.U)
      dut.io.wd.poke(-1.S)
      dut.io.we.poke(true.B)
      println(dut.io.rd.peek())
      dut.clock.step(1)
      println(dut.io.rd.peek())

      dut.io.a.poke(1.U)
      dut.clock.step(2)
      println(dut.io.rd.peek())
    }
  }
}


