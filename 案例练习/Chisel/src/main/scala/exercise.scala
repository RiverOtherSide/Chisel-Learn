import chisel3._
import chisel3.util._


//val open::opening::closed::closing::Nil = Enum(4)



class exercise extends Module{
  val io = IO(new Bundle() {
    val a = Input(UInt(8.W))
    val out = Output(UInt(4.W))
  })
  val open::opening::closed::closing::Nil = Enum(4)
//  import elevator
//  val buttons = RegInit(VecInit.fill(4)(closed))
  val bottom = Wire(Vec(3,UInt(1.W)))

  bottom(0) := 1.U
  bottom(1) := bottom(0) | 0.U
  bottom(2) := bottom(1) | 0.U
  io.out := bottom(2)===0.U | 1.U

}
