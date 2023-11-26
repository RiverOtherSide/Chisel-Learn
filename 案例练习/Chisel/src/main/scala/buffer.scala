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
    val out_empty = Output(Bool())
    val out_full = Output(Bool())
  })
  val buffer = RegInit(VecInit.fill(depth)(0.U(width.W)))

  val out_full = RegInit(false.B)
  io.out_full := out_full
  val out_empty = RegInit(false.B)
  io.out_empty := out_empty
  val out_data = RegInit(0.U(width.W))
  io.out_data := out_data

  val wrptr = RegInit(0.U(psize.W))
  val rdptr = RegInit(0.U(psize.W))
  val pdiff = Wire(Bool())

  pdiff := (rdptr===(wrptr+1.U))

  when(pdiff && io.in_wr && !io.in_rd){
    out_full :=true.B
  }.elsewhen(!io.in_wr && io.in_rd){
    out_full :=false.B
  }

  out_empty := (wrptr===rdptr) && (!out_full)

  when(io.in_wr){
    wrptr := Mux(wrptr<(depth-1).U,wrptr+1.U,0.U(psize.W))
  }

  when(io.in_rd){
    rdptr := Mux(rdptr<(depth-1).U,rdptr+1.U,0.U(psize.W))
  }

  when(io.in_wr){buffer(wrptr) := io.in_wdata}
  when(io.in_rd){out_data := buffer(rdptr)}


  assume(out_full && !io.in_wr)
  assume(out_empty && !io.in_rd)

//  val in_rd_ff1 = RegInit(false.B)
  val flag = RegInit(false.B)
  val rnd_mark = anyconst(1)
  val mark_vld = WireDefault(false.B)
  val check_vld = WireDefault(false.B)

  mark_vld := io.in_wr && rnd_mark.asBool
  check_vld := io.in_rd && (io.out_data === 0.U)
//  in_rd_ff1 := io.in_rd
  when(check_vld){
    flag := false.B
  }.elsewhen(mark_vld){
    flag := true.B
  }

//  assume(mark_vld && io.in_wdata===1.U)
//  assume(!mark_vld && io.in_wr && io.in_wdata===0.U)
//  assume(flag && !mark_vld)

  when(mark_vld){
    assume(io.in_wdata===1.U)
  }.otherwise{
    when(io.in_wr){
      assume(io.in_wdata===0.U)
    }
  }
  when(flag){
    assume(!mark_vld)
  }

  assert(check_vld && flag)
}

object bufferCheck extends App{
  Check bmc(() => new buffer(8,2))
}