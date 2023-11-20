FIRRTL version 1.1.0
circuit gcd :
  extmodule ResetCounter :
    input clk : Clock
    input reset : UInt<1>
    output timeSinceReset : UInt<32>
    output notChaos : UInt<1>
    defname = ResetCounter

  module gcd :
    input clock : Clock
    input reset : UInt<1>
    input io_a : UInt<8>
    input io_b : UInt<8>
    output io_o : UInt<8>
    output io_done : UInt<1>

    inst resetCounter of ResetCounter @[Formal.scala 10:36]
    reg lsb : UInt<3>, clock with :
      reset => (UInt<1>("h0"), lsb) @[gcd.scala 15:20]
    reg x : UInt<8>, clock with :
      reset => (UInt<1>("h0"), x) @[gcd.scala 16:16]
    reg y : UInt<8>, clock with :
      reset => (UInt<1>("h0"), y) @[gcd.scala 16:16]
    reg start : UInt<1>, clock with :
      reset => (UInt<1>("h0"), start) @[gcd.scala 17:22]
    node _x_lsb_T = dshr(x, lsb) @[gcd.scala 23:13]
    node _x_lsb_T_1 = bits(_x_lsb_T, 0, 0) @[gcd.scala 23:13]
    node _y_lsb_T = dshr(y, lsb) @[gcd.scala 24:13]
    node _y_lsb_T_1 = bits(_y_lsb_T, 0, 0) @[gcd.scala 24:13]
    node _diff_T = lt(x, y) @[gcd.scala 25:16]
    node _diff_T_1 = sub(y, x) @[gcd.scala 25:20]
    node _diff_T_2 = tail(_diff_T_1, 1) @[gcd.scala 25:20]
    node _diff_T_3 = sub(x, y) @[gcd.scala 25:24]
    node _diff_T_4 = tail(_diff_T_3, 1) @[gcd.scala 25:24]
    node _diff_T_5 = mux(_diff_T, _diff_T_2, _diff_T_4) @[gcd.scala 25:14]
    node _io_done_T = eq(x, y) @[gcd.scala 27:16]
    node _io_done_T_1 = eq(x, UInt<1>("h0")) @[gcd.scala 27:25]
    node _io_done_T_2 = or(_io_done_T, _io_done_T_1) @[gcd.scala 27:21]
    node _io_done_T_3 = eq(y, UInt<1>("h0")) @[gcd.scala 27:36]
    node _io_done_T_4 = or(_io_done_T_2, _io_done_T_3) @[gcd.scala 27:32]
    node _io_o_T = lt(x, y) @[gcd.scala 28:16]
    node _io_o_T_1 = mux(_io_o_T, x, y) @[gcd.scala 28:14]
    node _T = eq(x, y) @[gcd.scala 35:17]
    node _T_1 = eq(_T, UInt<1>("h0")) @[gcd.scala 35:14]
    node _T_2 = eq(x, UInt<1>("h0")) @[gcd.scala 35:26]
    node _T_3 = or(_T_1, _T_2) @[gcd.scala 35:22]
    node _T_4 = eq(y, UInt<1>("h0")) @[gcd.scala 35:37]
    node _T_5 = or(_T_3, _T_4) @[gcd.scala 35:33]
    node x_lsb = _x_lsb_T_1 @[gcd.scala 19:19 23:9]
    node y_lsb = _y_lsb_T_1 @[gcd.scala 20:19 24:9]
    node _T_6 = cat(x_lsb, y_lsb) @[gcd.scala 36:18]
    node _T_7 = eq(UInt<1>("h0"), _T_6) @[gcd.scala 36:27]
    node _lsb_T = add(lsb, UInt<1>("h1")) @[gcd.scala 37:29]
    node _lsb_T_1 = tail(_lsb_T, 1) @[gcd.scala 37:29]
    node _T_8 = eq(UInt<1>("h1"), _T_6) @[gcd.scala 36:27]
    node _x_T = dshr(x, UInt<1>("h1")) @[gcd.scala 38:23]
    node _T_9 = eq(UInt<2>("h2"), _T_6) @[gcd.scala 36:27]
    node _y_T = dshr(y, UInt<1>("h1")) @[gcd.scala 39:23]
    node _T_10 = eq(UInt<2>("h3"), _T_6) @[gcd.scala 36:27]
    node _T_11 = lt(x, y) @[gcd.scala 41:15]
    node diff = _diff_T_5 @[gcd.scala 21:18 25:8]
    node _y_T_1 = dshr(diff, UInt<1>("h1")) @[gcd.scala 42:18]
    node _x_T_1 = dshr(diff, UInt<1>("h1")) @[gcd.scala 44:18]
    node _GEN_0 = mux(_T_11, _y_T_1, y) @[gcd.scala 41:18 42:12 16:16]
    node _GEN_1 = mux(_T_11, x, _x_T_1) @[gcd.scala 16:16 41:18 44:12]
    node _GEN_2 = mux(_T_10, _GEN_0, y) @[gcd.scala 16:16 36:27]
    node _GEN_3 = mux(_T_10, _GEN_1, x) @[gcd.scala 16:16 36:27]
    node _GEN_4 = mux(_T_9, _y_T, _GEN_2) @[gcd.scala 36:27 39:20]
    node _GEN_5 = mux(_T_9, x, _GEN_3) @[gcd.scala 16:16 36:27]
    node _GEN_6 = mux(_T_8, _x_T, _GEN_5) @[gcd.scala 36:27 38:20]
    node _GEN_7 = mux(_T_8, y, _GEN_4) @[gcd.scala 16:16 36:27]
    node _GEN_8 = mux(_T_7, _lsb_T_1, lsb) @[gcd.scala 15:20 36:27 37:23]
    node _GEN_9 = mux(_T_7, x, _GEN_6) @[gcd.scala 16:16 36:27]
    node _GEN_10 = mux(_T_7, y, _GEN_7) @[gcd.scala 16:16 36:27]
    node _GEN_11 = mux(_T_5, _GEN_8, lsb) @[gcd.scala 15:20 35:45]
    node _GEN_12 = mux(_T_5, _GEN_9, x) @[gcd.scala 16:16 35:45]
    node _GEN_13 = mux(_T_5, _GEN_10, y) @[gcd.scala 16:16 35:45]
    node _GEN_14 = mux(start, io_a, _GEN_12) @[gcd.scala 31:15 32:7]
    node _GEN_15 = mux(start, io_b, _GEN_13) @[gcd.scala 31:15 33:7]
    node _GEN_16 = mux(start, UInt<1>("h0"), start) @[gcd.scala 31:15 34:11 17:22]
    node _GEN_17 = mux(start, lsb, _GEN_11) @[gcd.scala 31:15 15:20]
    node _T_12 = eq(io_a, UInt<3>("h6")) @[gcd.scala 49:12]
    node _T_13 = eq(io_b, UInt<3>("h4")) @[gcd.scala 49:26]
    node _T_14 = and(_T_12, _T_13) @[gcd.scala 49:19]
    node _T_15 = and(_T_14, io_done) @[gcd.scala 49:33]
    node _T_16 = eq(io_o, UInt<5>("h18")) @[gcd.scala 50:16]
    node _T_17 = bits(reset, 0, 0) @[gcd.scala 50:11]
    node _T_18 = eq(_T_17, UInt<1>("h0")) @[gcd.scala 50:11]
    node _T_19 = eq(_T_16, UInt<1>("h0")) @[gcd.scala 50:11]
    node _T_20 = bits(reset, 0, 0) @[gcd.scala 59:11]
    node _T_21 = eq(_T_20, UInt<1>("h0")) @[gcd.scala 59:11]
    node _T_22 = eq(io_done, UInt<1>("h0")) @[gcd.scala 59:11]
    io_o <= _io_o_T_1 @[gcd.scala 28:8]
    io_done <= _io_done_T_4 @[gcd.scala 27:11]
    resetCounter.clk <= clock @[Formal.scala 11:23]
    resetCounter.reset <= reset @[Formal.scala 12:25]
    lsb <= mux(reset, UInt<3>("h0"), _GEN_17) @[gcd.scala 15:{20,20}]
    x <= _GEN_14
    y <= _GEN_15
    start <= mux(reset, UInt<1>("h1"), _GEN_16) @[gcd.scala 17:{22,22}]
    printf(clock, and(and(and(and(and(UInt<1>("h1"), _T_15), resetCounter.notChaos), _T_18), _T_19), UInt<1>("h1")), "Assertion failed: \n    at Formal.scala:20 cassert(cond, msg)\n") : printf @[gcd.scala 50:11]
    assert(clock, _T_16, and(and(and(and(UInt<1>("h1"), _T_15), resetCounter.notChaos), _T_18), UInt<1>("h1")), "") : assert @[gcd.scala 50:11]
    printf(clock, and(and(and(and(and(UInt<1>("h1"), io_done), resetCounter.notChaos), _T_21), _T_22), UInt<1>("h1")), "Assertion failed: \n    at Formal.scala:20 cassert(cond, msg)\n") : printf_1 @[gcd.scala 59:11]
    assert(clock, io_done, and(and(and(and(UInt<1>("h1"), io_done), resetCounter.notChaos), _T_21), UInt<1>("h1")), "") : assert_1 @[gcd.scala 59:11]
