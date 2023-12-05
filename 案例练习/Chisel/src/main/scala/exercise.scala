import chisel3._
import chisel3.util._


//val open::opening::closed::closing::Nil = Enum(4)



class exercise extends Module{
  val io = IO(new Bundle() {
    val a = Input(UInt(8.W))
    val out = Output(Vec(4,Bool()))
    val random_up = Input(UInt(4.W))
  })
  val open::opening::closed::closing::Nil = Enum(4)
  val off::on::Nil = Enum(2)
//  import elevator
//  val buttons = RegInit(VecInit.fill(4)(closed))
//  val bottom = Wire(Vec(3,UInt(1.W)))
  val up_floor_buttons = RegInit(VecInit.fill(4)(false.B))
  io.out := up_floor_buttons
  for(i <- 0 until 3){
    when(io.random_up(i.U).asBool){
      up_floor_buttons(i.U) := on
    }
  }


}
