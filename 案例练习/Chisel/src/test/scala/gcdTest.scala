
import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec


class gcdTest extends AnyFlatSpec with ChiselScalatestTester{
  "gcd" should "pass" in{
    test(new gcd){
      gcd=>
        gcd.io.a.poke(28.U)
        gcd.io.b.poke(12.U)
//        gcd.io.start.poke(true.B)
//        gcd.io.start.poke(true.B)
        //        gcd.io.busy.poke(false.B)
        gcd.clock.step(cycles = 10)
        //        gcd.clock.step(cycles = 10)
//        assert(gcd.io.done.peekInt()!=2,"fail")
        println(gcd.io.done.peekInt())
        //        println(gcd.io.busy.peekInt())
        println(gcd.io.o.peekInt())
//        println(gcd.io.o_x.peekInt())
//        println(gcd.io.o_y.peekInt())
      //        gcd.io.o.expect(4.U)
    }
  }
}
