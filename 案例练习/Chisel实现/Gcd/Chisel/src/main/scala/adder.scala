import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class adder extends Module {
  val io = IO(new Bundle() {
    val a = Input(UInt(8.W))
    val b = Input(UInt(8.W))
    val o = Output(UInt(9.W))
    val o1 = Output(UInt(2.W))
  })

//  def add(a: SInt, b: SInt): SInt = {
//    a+b
//  }
  val c = RegInit(0.U(1.W))
  val d = RegInit(0.U(1.W))
  val e = RegInit(0.U(2.W))
  io.o := io.a+io.b
  c := io.a(io.b)
  d := io.a(3)
//  e :=
  io.o1 :=c ## d

}



object adderMain extends App{
  println("=====Begin=====")
  emitVerilog(new adder(),Array("--target-dir","generated"))
  println("======End======")
}