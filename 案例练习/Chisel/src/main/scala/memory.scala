
import chisel3._
import chiselFv._
import math._

// WIDTH = 256, PSIZE = 5, DEPTH = 2**PSIZE
class memory(width: Int=8,psize:Int=2) extends Module with Formal {
  val depth = pow(2,psize).toInt
  val io    = IO(new Bundle {
    val rst_n = Input(Bool())
    val in_wr = Input(Bool())
    val in_rd = Input(Bool())
    val in_data = Input(Bits(width.W))
    val in_wr_addr = Input(UInt(psize.W))
    val in_rd_addr = Input(UInt(psize.W))
    val out_data = Output(Bits(width.W))
  })

//  val mem = Reg(Vec(depth,Bits(width.W)))
  val mem = RegInit(VecInit.fill(depth)(0.U(width.W)))

  // for循环初始化
//  when(!io.rst_n){
//    for(i <- 0 until depth){
//      mem(i) := 0.B
//    }
//  }.else
  when(io.in_wr){
    mem(io.in_wr_addr) := Mux(io.in_wr_addr<(depth/2).U,io.in_data,io.in_data(width/2-1,0)##io.in_data(width-1,width/2))
  }

  io.out_data := mem(io.in_rd_addr)

  val random_addr = anyconst(psize)
  val random_addr_fail = anyconst(psize)
  val random_data = RegInit(0.U(width.W))
  val random_data_fail = RegInit(0.U(width.W))

  assume(!(io.in_wr&&io.in_rd))

//  when(!io.rst_n){
//    random_data := 0.B
//  }.else
  when(io.in_wr && (io.in_wr_addr===random_addr)&&(random_addr<(depth/2).U)){
    random_data := io.in_data
  }.elsewhen(io.in_wr && (io.in_wr_addr===random_addr)){
    random_data := io.in_data(width/2-1,0) ## io.in_data(width-1,width/2)
  }

//  when(!io.rst_n){
//    random_data_fail := 0.B
//  }.else
  when(io.in_wr&&(io.in_wr_addr===random_addr)&&(random_addr===random_addr_fail)){
    random_data_fail := io.in_data(width/2-1,0) ## io.in_data(width-1,width/2)
  }.elsewhen(io.in_wr&&(io.in_wr_addr===random_addr)&&(random_addr<(depth/2).U)){
    random_data_fail := io.in_data
  }.elsewhen(io.in_wr&&(io.in_wr_addr===random_addr)){
    random_data_fail := io.in_data(width/2-1,0) ## io.in_data(width-1,width/2)
  }

  when(io.in_rd&&(io.in_rd_addr===random_addr)){
    assert(io.out_data===random_data)
  }

//  when(io.in_rd&&(io.in_rd_addr===random_addr)){
//    assert(io.out_data===random_addr_fail)
//  }

//  assert(io.in_rd&&(io.in_rd_addr===random_addr)&&(io.out_data===random_addr_fail))
//  assertNextStepWhen(io.in_rd && (io.in_rd_addr === random_addr), io.out_data === random_data) // A |=> B

}

object memoryMain extends App {
  println("Generating the adder hardware")
  emitVerilog(new memory(), Array("--target-dir", "generated"))
}

object memoryCheck extends App{
  Check.bmc(() => new memory(256,2))
}
