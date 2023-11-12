import chisel3._
import chisel3.util._



class elevator extends Module{

}

object elevatorMain extends App{
  emitVerilog(new elevator(), Array("--target-dir", "generated"))
  println("end")
}



