circuit gcdtest :
  extmodule ResetCounter :
    input clk : Clock
    input reset : UInt<1>
    output timeSinceReset : UInt<32>
    output notChaos : UInt<1>
    defname = ResetCounter

  extmodule ResetCounter_1 :
    input clk : Clock
    input reset : UInt<1>
    output timeSinceReset : UInt<32>
    output notChaos : UInt<1>
    defname = ResetCounter

  module gcd :
    input clock : Clock
    input reset : Reset
    output io : { flip a : UInt<8>, flip b : UInt<8>, o : UInt<8>, done : UInt<1>}

    inst resetCounter of ResetCounter_1 @[Formal.scala 10:36]
    resetCounter.clk <= clock @[Formal.scala 11:23]
    resetCounter.reset <= reset @[Formal.scala 12:25]
    reg lsb : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[gcd.scala 15:20]
    reg x : UInt<8>, clock with :
      reset => (UInt<1>("h0"), x) @[gcd.scala 16:16]
    reg y : UInt<8>, clock with :
      reset => (UInt<1>("h0"), y) @[gcd.scala 16:16]
    reg start : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[gcd.scala 17:22]
    wire x_lsb : UInt<1> @[gcd.scala 19:19]
    wire y_lsb : UInt<1> @[gcd.scala 20:19]
    wire diff : UInt<8> @[gcd.scala 21:18]
    node _x_lsb_T = dshr(x, lsb) @[gcd.scala 23:13]
    node _x_lsb_T_1 = bits(_x_lsb_T, 0, 0) @[gcd.scala 23:13]
    x_lsb <= _x_lsb_T_1 @[gcd.scala 23:9]
    node _y_lsb_T = dshr(y, lsb) @[gcd.scala 24:13]
    node _y_lsb_T_1 = bits(_y_lsb_T, 0, 0) @[gcd.scala 24:13]
    y_lsb <= _y_lsb_T_1 @[gcd.scala 24:9]
    node _diff_T = lt(x, y) @[gcd.scala 25:16]
    node _diff_T_1 = sub(y, x) @[gcd.scala 25:20]
    node _diff_T_2 = tail(_diff_T_1, 1) @[gcd.scala 25:20]
    node _diff_T_3 = sub(x, y) @[gcd.scala 25:24]
    node _diff_T_4 = tail(_diff_T_3, 1) @[gcd.scala 25:24]
    node _diff_T_5 = mux(_diff_T, _diff_T_2, _diff_T_4) @[gcd.scala 25:14]
    diff <= _diff_T_5 @[gcd.scala 25:8]
    node _io_done_T = eq(x, y) @[gcd.scala 27:16]
    node _io_done_T_1 = eq(x, UInt<1>("h0")) @[gcd.scala 27:25]
    node _io_done_T_2 = or(_io_done_T, _io_done_T_1) @[gcd.scala 27:21]
    node _io_done_T_3 = eq(y, UInt<1>("h0")) @[gcd.scala 27:36]
    node _io_done_T_4 = or(_io_done_T_2, _io_done_T_3) @[gcd.scala 27:32]
    io.done <= _io_done_T_4 @[gcd.scala 27:11]
    node _io_o_T = lt(x, y) @[gcd.scala 28:16]
    node _io_o_T_1 = mux(_io_o_T, x, y) @[gcd.scala 28:14]
    io.o <= _io_o_T_1 @[gcd.scala 28:8]
    when start : @[gcd.scala 31:15]
      x <= io.a @[gcd.scala 32:7]
      y <= io.b @[gcd.scala 33:7]
      start <= UInt<1>("h0") @[gcd.scala 34:11]
    else :
      node _T = eq(x, y) @[gcd.scala 35:17]
      node _T_1 = eq(_T, UInt<1>("h0")) @[gcd.scala 35:14]
      node _T_2 = eq(x, UInt<1>("h0")) @[gcd.scala 35:26]
      node _T_3 = or(_T_1, _T_2) @[gcd.scala 35:22]
      node _T_4 = eq(y, UInt<1>("h0")) @[gcd.scala 35:37]
      node _T_5 = or(_T_3, _T_4) @[gcd.scala 35:33]
      when _T_5 : @[gcd.scala 35:45]
        node _T_6 = cat(x_lsb, y_lsb) @[gcd.scala 36:18]
        node _T_7 = eq(UInt<1>("h0"), _T_6) @[gcd.scala 36:27]
        when _T_7 : @[gcd.scala 36:27]
          node _lsb_T = add(lsb, UInt<1>("h1")) @[gcd.scala 37:29]
          node _lsb_T_1 = tail(_lsb_T, 1) @[gcd.scala 37:29]
          lsb <= _lsb_T_1 @[gcd.scala 37:23]
        else :
          node _T_8 = eq(UInt<1>("h1"), _T_6) @[gcd.scala 36:27]
          when _T_8 : @[gcd.scala 36:27]
            node _x_T = dshr(x, UInt<1>("h1")) @[gcd.scala 38:23]
            x <= _x_T @[gcd.scala 38:20]
          else :
            node _T_9 = eq(UInt<2>("h2"), _T_6) @[gcd.scala 36:27]
            when _T_9 : @[gcd.scala 36:27]
              node _y_T = dshr(y, UInt<1>("h1")) @[gcd.scala 39:23]
              y <= _y_T @[gcd.scala 39:20]
            else :
              node _T_10 = eq(UInt<2>("h3"), _T_6) @[gcd.scala 36:27]
              when _T_10 : @[gcd.scala 36:27]
                node _T_11 = lt(x, y) @[gcd.scala 41:15]
                when _T_11 : @[gcd.scala 41:18]
                  node _y_T_1 = dshr(diff, UInt<1>("h1")) @[gcd.scala 42:18]
                  y <= _y_T_1 @[gcd.scala 42:12]
                else :
                  node _x_T_1 = dshr(diff, UInt<1>("h1")) @[gcd.scala 44:18]
                  x <= _x_T_1 @[gcd.scala 44:12]
    node _T_12 = eq(io.a, UInt<3>("h6")) @[gcd.scala 49:12]
    node _T_13 = eq(io.b, UInt<3>("h4")) @[gcd.scala 49:26]
    node _T_14 = and(_T_12, _T_13) @[gcd.scala 49:19]
    node _T_15 = and(_T_14, io.done) @[gcd.scala 49:33]
    when _T_15 : @[gcd.scala 49:44]
      node _T_16 = eq(io.o, UInt<5>("h18")) @[gcd.scala 50:16]
      when resetCounter.notChaos : @[gcd.scala 50:11]
        node _T_17 = asUInt(reset) @[gcd.scala 50:11]
        node _T_18 = eq(_T_17, UInt<1>("h0")) @[gcd.scala 50:11]
        when _T_18 : @[gcd.scala 50:11]
          node _T_19 = eq(_T_16, UInt<1>("h0")) @[gcd.scala 50:11]
          when _T_19 : @[gcd.scala 50:11]
            printf(clock, UInt<1>("h1"), "Assertion failed: \n    at Formal.scala:20 cassert(cond, msg)\n") : printf @[gcd.scala 50:11]
          assert(clock, _T_16, UInt<1>("h1"), "") : assert @[gcd.scala 50:11]
    when io.done : @[gcd.scala 58:16]
      when resetCounter.notChaos : @[gcd.scala 59:11]
        node _T_20 = asUInt(reset) @[gcd.scala 59:11]
        node _T_21 = eq(_T_20, UInt<1>("h0")) @[gcd.scala 59:11]
        when _T_21 : @[gcd.scala 59:11]
          node _T_22 = eq(io.done, UInt<1>("h0")) @[gcd.scala 59:11]
          when _T_22 : @[gcd.scala 59:11]
            printf(clock, UInt<1>("h1"), "Assertion failed: \n    at Formal.scala:20 cassert(cond, msg)\n") : printf_1 @[gcd.scala 59:11]
          assert(clock, io.done, UInt<1>("h1"), "") : assert_1 @[gcd.scala 59:11]


  module gcdtest :
    input clock : Clock
    input reset : UInt<1>

    inst resetCounter of ResetCounter @[Formal.scala 10:36]
    resetCounter.clk <= clock @[Formal.scala 11:23]
    resetCounter.reset <= reset @[Formal.scala 12:25]
    inst dut of gcd @[gcd.scala 68:19]
    dut.clock <= clock
    dut.reset <= reset
    dut.io.a <= UInt<5>("h1c") @[gcd.scala 69:12]
    dut.io.b <= UInt<4>("hc") @[gcd.scala 70:12]
    node _T = eq(dut.io.o, UInt<4>("hc")) @[gcd.scala 72:24]
    node _T_1 = eq(resetCounter.timeSinceReset, UInt<1>("h1")) @[gcd.scala 72:11]
    node _T_2 = and(resetCounter.notChaos, _T_1) @[gcd.scala 72:11]
    when _T_2 : @[gcd.scala 72:11]
      node _T_3 = bits(reset, 0, 0) @[gcd.scala 72:11]
      node _T_4 = eq(_T_3, UInt<1>("h0")) @[gcd.scala 72:11]
      when _T_4 : @[gcd.scala 72:11]
        node _T_5 = eq(_T, UInt<1>("h0")) @[gcd.scala 72:11]
        when _T_5 : @[gcd.scala 72:11]
          printf(clock, UInt<1>("h1"), "Assertion failed: \n    at Formal.scala:28 cassert(cond, msg)\n") : printf @[gcd.scala 72:11]
        assert(clock, _T, UInt<1>("h1"), "") : assert @[gcd.scala 72:11]
    node _T_6 = eq(dut.io.done, UInt<1>("h0")) @[gcd.scala 73:27]
    node _T_7 = eq(resetCounter.timeSinceReset, UInt<1>("h1")) @[gcd.scala 73:11]
    node _T_8 = and(resetCounter.notChaos, _T_7) @[gcd.scala 73:11]
    when _T_8 : @[gcd.scala 73:11]
      node _T_9 = bits(reset, 0, 0) @[gcd.scala 73:11]
      node _T_10 = eq(_T_9, UInt<1>("h0")) @[gcd.scala 73:11]
      when _T_10 : @[gcd.scala 73:11]
        node _T_11 = eq(_T_6, UInt<1>("h0")) @[gcd.scala 73:11]
        when _T_11 : @[gcd.scala 73:11]
          printf(clock, UInt<1>("h1"), "Assertion failed: \n    at Formal.scala:28 cassert(cond, msg)\n") : printf_1 @[gcd.scala 73:11]
        assert(clock, _T_6, UInt<1>("h1"), "") : assert_1 @[gcd.scala 73:11]
    node _T_12 = eq(dut.io.o, UInt<3>("h4")) @[gcd.scala 75:26]
    node _T_13 = eq(resetCounter.timeSinceReset, UInt<3>("h6")) @[gcd.scala 75:11]
    node _T_14 = and(resetCounter.notChaos, _T_13) @[gcd.scala 75:11]
    when _T_14 : @[gcd.scala 75:11]
      node _T_15 = bits(reset, 0, 0) @[gcd.scala 75:11]
      node _T_16 = eq(_T_15, UInt<1>("h0")) @[gcd.scala 75:11]
      when _T_16 : @[gcd.scala 75:11]
        node _T_17 = eq(_T_12, UInt<1>("h0")) @[gcd.scala 75:11]
        when _T_17 : @[gcd.scala 75:11]
          printf(clock, UInt<1>("h1"), "Assertion failed: \n    at Formal.scala:28 cassert(cond, msg)\n") : printf_2 @[gcd.scala 75:11]
        assert(clock, _T_12, UInt<1>("h1"), "") : assert_2 @[gcd.scala 75:11]
    node _T_18 = eq(dut.io.done, UInt<1>("h1")) @[gcd.scala 76:29]
    node _T_19 = eq(resetCounter.timeSinceReset, UInt<3>("h6")) @[gcd.scala 76:11]
    node _T_20 = and(resetCounter.notChaos, _T_19) @[gcd.scala 76:11]
    when _T_20 : @[gcd.scala 76:11]
      node _T_21 = bits(reset, 0, 0) @[gcd.scala 76:11]
      node _T_22 = eq(_T_21, UInt<1>("h0")) @[gcd.scala 76:11]
      when _T_22 : @[gcd.scala 76:11]
        node _T_23 = eq(_T_18, UInt<1>("h0")) @[gcd.scala 76:11]
        when _T_23 : @[gcd.scala 76:11]
          printf(clock, UInt<1>("h1"), "Assertion failed: \n    at Formal.scala:28 cassert(cond, msg)\n") : printf_3 @[gcd.scala 76:11]
        assert(clock, _T_18, UInt<1>("h1"), "") : assert_3 @[gcd.scala 76:11]


