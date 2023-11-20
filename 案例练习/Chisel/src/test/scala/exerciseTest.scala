


import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class exerciseTest extends AnyFlatSpec with ChiselScalatestTester {

  "exercise" should "work" in {
    test(new exercise) { dut =>
      println(dut.io.out.peek())
      dut.io.a.poke("b11110000".U)
      dut.clock.step(1)
      println(dut.io.out.peek())
    }
  }
}




