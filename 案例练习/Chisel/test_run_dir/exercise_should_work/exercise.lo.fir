FIRRTL version 1.1.0
circuit exercise :
  module exercise :
    input clock : Clock
    input reset : UInt<1>
    input io_a : UInt<8>
    output io_out_0 : UInt<1>
    output io_out_1 : UInt<1>
    output io_out_2 : UInt<1>
    output io_out_3 : UInt<1>
    input io_random_up : UInt<4>

    reg up_floor_buttons_0 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), up_floor_buttons_0) @[exercise.scala 20:33]
    reg up_floor_buttons_1 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), up_floor_buttons_1) @[exercise.scala 20:33]
    reg up_floor_buttons_2 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), up_floor_buttons_2) @[exercise.scala 20:33]
    reg up_floor_buttons_3 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), up_floor_buttons_3) @[exercise.scala 20:33]
    node _T = dshr(io_random_up, UInt<1>("h0")) @[exercise.scala 23:22]
    node _T_1 = bits(_T, 0, 0) @[exercise.scala 23:22]
    node _T_2 = bits(_T_1, 0, 0) @[exercise.scala 23:28]
    node _GEN_0 = mux(_T_2, UInt<1>("h1"), up_floor_buttons_0) @[exercise.scala 23:35 24:29 20:33]
    node _T_3 = dshr(io_random_up, UInt<1>("h1")) @[exercise.scala 23:22]
    node _T_4 = bits(_T_3, 0, 0) @[exercise.scala 23:22]
    node _T_5 = bits(_T_4, 0, 0) @[exercise.scala 23:28]
    node _GEN_1 = mux(_T_5, UInt<1>("h1"), up_floor_buttons_1) @[exercise.scala 23:35 24:29 20:33]
    node _T_6 = dshr(io_random_up, UInt<2>("h2")) @[exercise.scala 23:22]
    node _T_7 = bits(_T_6, 0, 0) @[exercise.scala 23:22]
    node _T_8 = bits(_T_7, 0, 0) @[exercise.scala 23:28]
    node _GEN_2 = mux(_T_8, UInt<1>("h1"), up_floor_buttons_2) @[exercise.scala 23:35 24:29 20:33]
    node _up_floor_buttons_WIRE_0 = UInt<1>("h0") @[exercise.scala 20:{49,49}]
    node _up_floor_buttons_WIRE_1 = UInt<1>("h0") @[exercise.scala 20:{49,49}]
    node _up_floor_buttons_WIRE_2 = UInt<1>("h0") @[exercise.scala 20:{49,49}]
    node _up_floor_buttons_WIRE_3 = UInt<1>("h0") @[exercise.scala 20:{49,49}]
    io_out_0 <= up_floor_buttons_0 @[exercise.scala 21:10]
    io_out_1 <= up_floor_buttons_1 @[exercise.scala 21:10]
    io_out_2 <= up_floor_buttons_2 @[exercise.scala 21:10]
    io_out_3 <= up_floor_buttons_3 @[exercise.scala 21:10]
    up_floor_buttons_0 <= mux(reset, _up_floor_buttons_WIRE_0, _GEN_0) @[exercise.scala 20:{33,33}]
    up_floor_buttons_1 <= mux(reset, _up_floor_buttons_WIRE_1, _GEN_1) @[exercise.scala 20:{33,33}]
    up_floor_buttons_2 <= mux(reset, _up_floor_buttons_WIRE_2, _GEN_2) @[exercise.scala 20:{33,33}]
    up_floor_buttons_3 <= mux(reset, _up_floor_buttons_WIRE_3, up_floor_buttons_3) @[exercise.scala 20:{33,33,33}]
