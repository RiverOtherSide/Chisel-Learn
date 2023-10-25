FIRRTL version 1.1.0
circuit adder :
  module adder :
    input clock : Clock
    input reset : UInt<1>
    input io_a : UInt<8>
    input io_b : UInt<8>
    output io_o : UInt<9>
    output io_o1 : UInt<2>

    reg c : UInt<1>, clock with :
      reset => (UInt<1>("h0"), c) @[adder.scala 16:18]
    reg d : UInt<1>, clock with :
      reset => (UInt<1>("h0"), d) @[adder.scala 17:18]
    reg e : UInt<2>, clock with :
      reset => (UInt<1>("h0"), e) @[adder.scala 18:18]
    node _io_o_T = add(io_a, io_b) @[adder.scala 19:15]
    node _io_o_T_1 = tail(_io_o_T, 1) @[adder.scala 19:15]
    node _c_T = dshr(io_a, io_b) @[adder.scala 20:12]
    node _c_T_1 = bits(_c_T, 0, 0) @[adder.scala 20:12]
    node _d_T = bits(io_a, 3, 3) @[adder.scala 21:12]
    node _io_o1_T = cat(d, c) @[adder.scala 23:15]
    io_o <= pad(_io_o_T_1, 9) @[adder.scala 19:8]
    io_o1 <= _io_o1_T @[adder.scala 23:9]
    c <= mux(reset, UInt<1>("h0"), _c_T_1) @[adder.scala 16:{18,18} 20:5]
    d <= mux(reset, UInt<1>("h0"), _d_T) @[adder.scala 17:{18,18} 21:5]
    e <= mux(reset, UInt<2>("h0"), e) @[adder.scala 18:{18,18,18}]
