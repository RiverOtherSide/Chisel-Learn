import chisel3._
import chisel3.util._

// 该模块描述了一个位矩阵，用于存储对称的、自反的
// 关系。 仅矩阵的下三角形（不包括对角线）
// 存储在线性位数组中。 对角线的值必须是
// 固定的。 （要么全为 1，要么全为 0。）

// MSB of the row and column indices.

// Number of rows and columns of the full square matrix.
// It must be N = 2**(MSB+1).

// Number of locations in the lower triangle of the matrix (diagonal
// excluded).  It must be L = \sum_{0 < i < N} i = (N * (N-1))/2.
class matrix(MSB:Int=2,N:Int=8,L:Int=28) extends Module{
  val io = IO(new Bundle() {
    val row = Input(UInt((MSB+1).W))
    val col = Input(UInt((MSB+1).W))
    val r_w = Input(Bool())  // 1: read, 0: write
    val bitIn = Input(UInt(1.W))

    val bitOut = Output(UInt(1.W))
  })
  val M = RegInit(VecInit.fill(L)(0.U(1.W)))
  val posn = RegInit(0.U)
  val offset = Reg(Vec(N-1,UInt((MSB*2+1).W)))

  when(reset.asBool){
    var k = 0
    for(i<-0 until N){
      offset(i.U) := k.U
      k = k+i+1
    }
  }

  when(io.row =/= io.col){
    posn := Mux(io.row<io.col
                ,offset(io.col-1.U)+ io.row
                ,offset(io.row-1.U)+ io.col)-1.U
    when(!io.r_w){
      M(posn) := io.bitIn
    }
  }

  val bitOut = RegInit(0.U(1.W))
  io.bitOut := bitOut
  bitOut := Mux(io.r_w,Mux(io.row===io.col,1.U,M(posn)),0.U)

}
