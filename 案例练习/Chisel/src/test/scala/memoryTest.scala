

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec


class memoryTest extends AnyFlatSpec with ChiselScalatestTester{
  "memory" should "pass" in{
    test(new memory){
      dut=>
        dut.io.rst_n.poke(true.B)
        dut.io.in_rd.poke(true.B)
        dut.io.in_wr.poke(true.B)
        dut.io.in_rd_addr.poke(0.U)
        dut.io.in_wr_addr.poke(0.U)
        dut.io.in_data.poke(0.B)
        dut.clock.step(cycles = 1)
        println(dut.io.out_data.peekInt())

        dut.io.rst_n.poke(false.B)
        dut.io.in_rd.poke(true.B)
        dut.io.in_wr.poke(true.B)
//        dut.reset.
        dut.io.in_rd_addr.poke(0.U)
        dut.io.in_wr_addr.poke(0.U)
        dut.io.in_data.poke("d520".U)
        dut.clock.step(cycles = 2)
        println(dut.io.out_data.peekInt())
    }
  }
}

