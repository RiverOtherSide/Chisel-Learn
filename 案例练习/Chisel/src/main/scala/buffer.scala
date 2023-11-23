import chisel3._
import math._
import chiselFv._

class buffer(width:Int=8,psize:Int=2) extends Module with Formal {
  val depth = pow(2,psize).toInt
  val io = IO(new Bundle() {
    val rst_n = Input(Bool())
    val in_wr = Input(Bool())
    val in_wdata = Input(Bits(width.W))
    val in_rd = Input(Bool())
    val out_data = Output(Bits(width.W))
//    val out_empty = Output(Bool())
    val out_full = Output(Bool())
  })
  val buffer = RegInit(VecInit.fill(depth)(0.U(width.W)))

  val out_full = RegInit(false.B)
  io.out_full := out_full

  val wrptr = RegInit(0.U(psize.W))
  val rdptr = RegInit(0.U(psize.W))
  val pdiff = Wire(Bool())

  pdiff := (rdptr===(wrptr+1.U))

  when(pdiff && io.in_wr && !io.in_rd){
    out_full :=true.B
  }.elsewhen(!io.in_wr && io.in_rd){
    out_full :=false.B
  }
//    .otherwise{
//    out_full := out_full
//  }

  when(io.in_wr){
    wrptr := Mux(wrptr<(depth-1).U,wrptr+1.U,0.U(psize.W))
  }
//    .otherwise{
//    wrptr := wrptr
//  }

  when(io.in_rd){
    rdptr := Mux(rdptr<(depth-1).U,rdptr+1.U,0.U(psize.W))
  }
//    .otherwise{
//    rdptr := rdptr
//  }

  when(io.in_wr){buffer(wrptr) := io.in_wdata}

  val out_data = RegInit(0.U(width.W))
  io.out_data := out_data
  when(io.in_rd){out_data := buffer(rdptr)}


}
