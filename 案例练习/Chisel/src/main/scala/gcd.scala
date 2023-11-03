
import chisel3._
import chisel3.util._

class gcd extends Module {
  val io = IO(new Bundle {
    val a = Input(UInt(8.W))
    val b = Input(UInt(8.W))
    val start = Input(Bool())

    //    val busy = Output(Bool())
    val o = Output(UInt(8.W))
    val done = Output(Bool())
  })

  val lsb = RegInit(0.U(3.W))
  val x = RegInit(0.U(8.W))
  val y = RegInit(0.U(8.W))
  val busy = RegInit(false.B)

  val done = Wire(Bool())
  val load = Wire(Bool())

  val x_lsb = Wire(UInt(1.W))
  val y_lsb = Wire(UInt(1.W))
  val diff = Wire(UInt(8.W))

  //  def select(z:UInt,lsb:UInt):UInt={
  //    z(lsb)
  //  }

  io.o := Mux(io.a>io.b, io.b,io.a)

  x_lsb := x(lsb)
  y_lsb := y(lsb)
  diff := Mux(x<y,y-x,x-y)

  done := ((x===y)||(x===0.U)||(y===0.U))&&busy

  when(load){
    x := io.a
    y := io.b
    lsb := 0.U
  }.elsewhen(busy & ~done){
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
  }.elsewhen(done) {
    io.o := Mux(x<y,x,y)
  }

  load := io.start && (!busy)

  when(!busy){
    when(io.start){busy:=true.B}
  }.otherwise{
    when(done){busy:=false.B}
  }

  io.done := done
}

object gcdMain extends App {
  println("Generating the adder hardware")
  emitVerilog(new gcd(), Array("--target-dir", "generated"))
}