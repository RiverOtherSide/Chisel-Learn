
import chisel3._
import chisel3.util._

class Main extends Module {
  val io = IO(new Bundle {
    val a = Input(UInt(8.W))
    val b = Input(UInt(8.W))
    val start = Input(UInt(1.W))

    val busy = Output(UInt(1.W))
    val o = Output(UInt(8.W))
  })

  val lsb = RegInit(0.U(3.W))
  val x = RegInit(0.U(8.W))
  val y = RegInit(0.U(8.W))

  val done = Wire(UInt(1.W))
  val load = Wire(UInt(1.W))

  val xy_lsb = Wire(UInt(2.W))
  val diff = Wire(UInt(8.W))

  def select(z:UInt,lsb:UInt):UInt={
  if(lsb == 0.U(3.W)){
    z(0)
  }else if(lsb == 1.U(3.W)) {
    z(1)
  } else if (lsb == 2.U(3.W)) {
    z(2)
  } else if (lsb == 3.U(3.W)) {
    z(3)
  } else if (lsb == 4.U(3.W)) {
    z(4)
  } else if (lsb == 5.U(3.W)) {
    z(5)
  } else if (lsb == 6.U(3.W)) {
    z(6)
  }else{
    z(7)
  }
  }

  
  xy_lsb(0) = select(x,lsb)
  xy_lsb(1) = select(y,lsb)



  val reg = RegInit(0.U(8.W))
  reg := io.a + io.b

  io.c := reg
}

object AddMain extends App {
  println("Generating the adder hardware")
  emitVerilog(new Main(), Array("--target-dir", "generated"))
}