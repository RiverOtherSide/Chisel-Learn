
import chisel3._
import chisel3.util._
import chiselFv._

class gcd extends Module with Formal {
  val io = IO(new Bundle {
    val a = Input(UInt(8.W))
    val b = Input(UInt(8.W))

    val o = Output(UInt(8.W))
    val done = Output(Bool())
  })
  //RegInit初始化值无法为io或者wire
  val lsb = RegInit(0.U(3.W))
  val x,y = Reg(UInt(8.W))
  val start = RegInit(true.B)
//
  val x_lsb = Wire(UInt(1.W))
  val y_lsb = Wire(UInt(1.W))
  val diff = Wire(UInt(8.W))

  x_lsb := x(lsb)
  y_lsb := y(lsb)
  diff := Mux(x<y,y-x,x-y)

  io.done := (x===y)||(x===0.U)||(y===0.U)
  io.o := Mux(x<y,x,y)
//  io.o := 2.U

  when(start) {
    x := io.a
    y := io.b
    start := false.B
  }.elsewhen(!(x===y)||(x===0.U)||(y===0.U)){
    switch(x_lsb ## y_lsb){
      is("b00".U){lsb := lsb+1.U}
      is("b01".U){x:=x>>1.U}
      is("b10".U){y:=y>>1.U}
      is("b11".U){
        when(x<y){
          y:=diff>>1.U
        }.otherwise{
          x:=diff>>1.U
        }}
    }
  }

  when(io.a===6.U && io.b===4.U && io.done){
    assert(io.o===2.U)
  }
//  def gcd(a:UInt,b:Int):Int={
//
//}
//  val a,b = anyconst(8)
//  assert()

  when(io.done){
    assert(io.done)
//    assume(io.o=/=0.U)
//    assert((io.a % io.o)===0.U,"??")
//    assert(io.o>0.U||io.o===0.U)
  }
}


class gcdtest extends Module with Formal{
  val dut = Module(new gcd())
  dut.io.a := 28.U
  dut.io.b := 12.U

  assertAt(1.U,dut.io.o===12.U)
  assertAt(1.U,dut.io.done===false.B)

  assertAt(6.U, dut.io.o === 4.U)
  assertAt(6.U, dut.io.done === true.B)
}

object gcdMain extends App {
  println("Generating the adder hardware")
  emitVerilog(new gcd(), Array("--target-dir", "generated"))
}

object gcdCheck1 extends App{
  Check.bmc(() => new gcd())
}
object gcdCheck2 extends App{
  Check.bmc(() => new gcdtest())
}