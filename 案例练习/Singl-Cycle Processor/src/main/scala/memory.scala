import chisel3._
import chisel3.util._

class memory extends Module {
  val io = IO(new Bundle{
    val A = Input(UInt(32.W))
    val WD = Input(SInt(32.W))
    val WE = Input(Bool())

    val RD = Output(SInt(32.W))
  })
  val mem = SyncReadMem(1024,SInt(32.W))

  io.RD := mem.read(io.A)
  when(io.WE) {
    mem.write(io.A, io.WD)
  }
}
