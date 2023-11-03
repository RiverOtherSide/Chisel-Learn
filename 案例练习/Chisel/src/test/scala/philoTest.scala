
import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import chisel3.util._


class philoTest extends AnyFlatSpec with ChiselScalatestTester{

  val busy::leftbusy::rightbusy::idle::Nil = Enum(4)

  "philo" should "pass" in{
    test(new philo){
      dut=>
        dut.io.ph1_init.poke(busy)
        dut.io.ph2_init.poke(idle)
        dut.io.ph3_init.poke(rightbusy)
        dut.io.ph4_init.poke(idle)
        //        gcd.io.busy.poke(false.B)
        dut.clock.step(cycles = 1)
        //        gcd.clock.step(cycles = 10)
        println(dut.io.ph1_out.peekInt())
        println(dut.io.ph2_out.peekInt())
        println(dut.io.ph3_out.peekInt())
        println(dut.io.ph4_out.peekInt())

    }
  }
}

class philosopherTest extends AnyFlatSpec with ChiselScalatestTester{
  val busy::leftbusy::rightbusy::idle::Nil = Enum(4)

  "dut" should "pass" in{
    test(new philosopher(idle)){
      dut=>
//        dut.io.state_init.poke(3.U)
//        dut.io.go.poke(true.B)
        dut.io.left.poke(2.U)
        dut.io.right.poke(2.U)
//        dut.io.b.poke(4.U)
//        dut.io.start.poke(true.B)
        //        gcd.io.busy.poke(false.B)
        dut.clock.step(cycles = 4)
        //        gcd.clock.step(cycles = 10)
        println(dut.io.out.peekInt())
        //        println(gcd.io.busy.peekInt())
//        println(dut.io.o.peekInt())
//              gcd.io.o.expect(4.U)
    }
  }
}
