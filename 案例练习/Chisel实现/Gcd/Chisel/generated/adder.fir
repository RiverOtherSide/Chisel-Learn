circuit adder :
  module adder :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip a : SInt<8>, flip b : SInt<8>, o : SInt<8>}

    node _io_o_T = mul(io.a, io.b) @[adder.scala 13:24]
    io.o <= _io_o_T @[adder.scala 15:8]

