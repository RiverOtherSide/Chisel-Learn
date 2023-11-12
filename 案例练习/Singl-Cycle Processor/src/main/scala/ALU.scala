import chisel3._
import chisel3.util._


class ALU extends Module{
  val io = IO(new Bundle() {
    val SrcA = Input(SInt(32.W))
    val SrcB = Input(SInt(32.W))
    val ALUControl = Input(UInt(3.W))
    val ALUResult = Output(SInt(32.W))
  })

  val result = WireDefault(SInt(32.W),io.SrcA)
  val add::sub::and::or::_::slt::_::_::Nil = Enum(8)
  io.ALUResult := result
  switch(io.ALUControl){
    is(add){result := io.SrcA+io.SrcB}
    is(sub){result := io.SrcA-io.SrcB}
    is(and){result := io.SrcA & io.SrcB}
    is(or){result := io.SrcA | io.SrcB}
//    is(add){result := io.SrcA+io.SrcB}
    is(slt){when(io.SrcA<io.SrcB){result := 1.S}.otherwise(result := 0.S)}
//    is(add){result := io.SrcA+io.SrcB}
//    is(add){result := io.SrcA+io.SrcB}
  }


}
