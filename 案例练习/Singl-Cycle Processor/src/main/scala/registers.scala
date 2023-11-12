import chisel3._
import chisel3.util._

class registers extends Module{
  val io = IO(new Bundle() {
    val A1 = Input(UInt(5.W))
    val A2 = Input(UInt(5.W))
    val A3 = Input(UInt(5.W))
    val WE3 = Input(Bool())
    val WD3 = Input(SInt(32.W))

    val RD1 = Output(SInt(32.W))
    val RD2 = Output(SInt(32.W))
  })
  
}
