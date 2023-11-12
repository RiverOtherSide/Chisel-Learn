

import chisel3._
import chisel3.util._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class ALUTest extends AnyFlatSpec with ChiselScalatestTester {
  val add::sub::and::or::_::slt::_::_::Nil = Enum(8)
  "ALU" should "work" in {
    test(new ALU) { dut =>
      dut.io.SrcA.poke(3.S)
      dut.io.SrcB.poke(-5.S)
      dut.io.ALUControl.poke(slt)
      dut.clock.step(1)
      println(dut.io.ALUResult.peek())
    }
  }
}

