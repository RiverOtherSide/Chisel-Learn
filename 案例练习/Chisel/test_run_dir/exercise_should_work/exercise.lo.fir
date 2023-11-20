FIRRTL version 1.1.0
circuit exercise :
  module exercise :
    input clock : Clock
    input reset : UInt<1>
    input io_a : UInt<8>
    output io_out : UInt<4>

    node bottom_0 = UInt<1>("h1") @[exercise.scala 17:20 19:13]
    node _bottom_1_T = or(bottom_0, UInt<1>("h0")) @[exercise.scala 20:26]
    node bottom_1 = _bottom_1_T @[exercise.scala 17:20 20:13]
    node _bottom_2_T = or(bottom_1, UInt<1>("h0")) @[exercise.scala 21:26]
    node bottom_2 = _bottom_2_T @[exercise.scala 17:20 21:13]
    node _io_out_T = eq(bottom_2, UInt<1>("h0")) @[exercise.scala 22:22]
    node _io_out_T_1 = or(_io_out_T, UInt<1>("h1")) @[exercise.scala 22:29]
    io_out <= pad(_io_out_T_1, 4) @[exercise.scala 22:10]
