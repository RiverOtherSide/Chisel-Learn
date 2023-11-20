FIRRTL version 1.1.0
circuit adder :
  module adder :
    input clock : Clock
    input reset : UInt<1>
    input io_a : UInt<8>
    input io_b : UInt<8>
    output io_c : UInt<8>

    reg reg : UInt<8>, clock with :
      reset => (UInt<1>("h0"), reg) @[adder.scala 12:20]
    node _reg_T = rem(io_a, io_b) @[adder.scala 13:15]
    io_c <= reg @[adder.scala 15:8]
    reg <= mux(reset, UInt<8>("h0"), _reg_T) @[adder.scala 12:{20,20} 13:7]
