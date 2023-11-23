
import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec


class bufferTest extends AnyFlatSpec with ChiselScalatestTester{
  "buffer" should "pass" in{
    test(new buffer){
      dut=>
//        dut.io.rst_n.poke(true.B)
        dut.io.in_rd.poke(false.B)
        dut.io.in_wr.poke(true.B)
        dut.io.in_wdata.poke(1.U)
        dut.clock.step(cycles = 1)

        dut.io.in_rd.poke(false.B)
        dut.io.in_wr.poke(true.B)
        dut.io.in_wdata.poke(2.U)
        dut.clock.step(cycles = 1)

        dut.io.in_rd.poke(false.B)
        dut.io.in_wr.poke(true.B)
        dut.io.in_wdata.poke(3.U)
        dut.clock.step(cycles = 1)
//        println(dut.io.out_data.peekInt())

        dut.io.in_rd.poke(true.B)
        dut.io.in_wr.poke(false.B)
        dut.io.in_wdata.poke(4.U)
        dut.clock.step(cycles = 1)
        println(dut.io.out_data.peekInt())

        dut.io.in_rd.poke(true.B)
        dut.io.in_wr.poke(false.B)
        dut.io.in_wdata.poke(4.U)
        dut.clock.step(cycles = 1)
        println(dut.io.out_data.peekInt())

        dut.io.in_rd.poke(true.B)
        dut.io.in_wr.poke(false.B)
        dut.io.in_wdata.poke(4.U)
        dut.clock.step(cycles = 1)
        println(dut.io.out_data.peekInt())

        dut.io.in_rd.poke(true.B)
        dut.io.in_wr.poke(false.B)
        dut.io.in_wdata.poke(4.U)
        dut.clock.step(cycles = 1)
        println(dut.io.out_data.peekInt())
    }
  }
}


