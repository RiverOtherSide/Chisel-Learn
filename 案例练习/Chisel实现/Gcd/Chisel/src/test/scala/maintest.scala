
import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec


class adderTest extends AnyFlatSpec with ChiselScalatestTester{
  "adder" should "pass" in{
    test(new adder){
      adder=>
        adder.io.a.poke(4.U)
        adder.io.b.poke(2.U)
        adder.clock.step()
        println(adder.io.o.peekInt())
        println(adder.io.o1.peek())
        adder.io.o.expect(25.U)

    }
  }
}

class gcdTest extends AnyFlatSpec with ChiselScalatestTester{
  "gcd" should "pass" in{
    test(new gcd){
      gcd=>
        gcd.io.a.poke(6.U)
        gcd.io.b.poke(4.U)
        gcd.io.start.poke(true.B)
//        gcd.io.busy.poke(false.B)
        gcd.clock.step(cycles = 4)
//        gcd.clock.step(cycles = 10)
        println(gcd.io.done.peekInt())
//        println(gcd.io.busy.peekInt())
        println(gcd.io.o.peekInt())
//        gcd.io.o.expect(4.U)
    }
  }
}
