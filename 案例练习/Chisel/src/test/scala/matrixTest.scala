
import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec


class matrixTest extends AnyFlatSpec with ChiselScalatestTester{
  "matrix" should "pass" in{
    test(new matrix){
      dut=>
        dut.io.row.poke(1.U)
        dut.io.col.poke(2.U)
        dut.io.r_w.poke(false.B)
        dut.io.bitIn.poke("b1".U)
        println(dut.io.bitOut.peek())
        dut.clock.step(2)
        dut.io.row.poke(1.U)
        dut.io.col.poke(2.U)
        dut.io.r_w.poke(true.B)
        println(dut.io.bitOut.peek())
        dut.clock.step(1)
        println(dut.io.bitOut.peek())
    }
  }
}
