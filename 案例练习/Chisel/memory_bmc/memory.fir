circuit memory :
  extmodule ResetCounter :
    input clk : Clock
    input reset : UInt<1>
    output timeSinceReset : UInt<32>
    output notChaos : UInt<1>
    defname = ResetCounter

  extmodule AnyConst :
    output out : UInt<2>
    defname = AnyConst
    parameter WIDTH = 2

  extmodule AnyConst_1 :
    output out : UInt<2>
    defname = AnyConst
    parameter WIDTH = 2

  module memory :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip rst_n : UInt<1>, flip in_wr : UInt<1>, flip in_rd : UInt<1>, flip in_data : UInt<256>, flip in_wr_addr : UInt<2>, flip in_rd_addr : UInt<2>, out_data : UInt<256>}

    inst resetCounter of ResetCounter @[Formal.scala 10:36]
    resetCounter.clk <= clock @[Formal.scala 11:23]
    resetCounter.reset <= reset @[Formal.scala 12:25]
    wire _mem_WIRE : UInt<256>[4] @[memory.scala 20:40]
    _mem_WIRE[0] <= UInt<256>("h0") @[memory.scala 20:40]
    _mem_WIRE[1] <= UInt<256>("h0") @[memory.scala 20:40]
    _mem_WIRE[2] <= UInt<256>("h0") @[memory.scala 20:40]
    _mem_WIRE[3] <= UInt<256>("h0") @[memory.scala 20:40]
    reg mem : UInt<256>[4], clock with :
      reset => (reset, _mem_WIRE) @[memory.scala 20:20]
    when io.in_wr : @[memory.scala 28:17]
      node _mem_T = lt(io.in_wr_addr, UInt<2>("h2")) @[memory.scala 29:44]
      node _mem_T_1 = bits(io.in_data, 127, 0) @[memory.scala 29:78]
      node _mem_T_2 = bits(io.in_data, 255, 128) @[memory.scala 29:103]
      node _mem_T_3 = cat(_mem_T_1, _mem_T_2) @[memory.scala 29:91]
      node _mem_T_4 = mux(_mem_T, io.in_data, _mem_T_3) @[memory.scala 29:30]
      mem[io.in_wr_addr] <= _mem_T_4 @[memory.scala 29:24]
    io.out_data <= mem[io.in_rd_addr] @[memory.scala 32:15]
    inst random_addr_cst of AnyConst @[Formal.scala 93:21]
    inst random_addr_fail_cst of AnyConst_1 @[Formal.scala 93:21]
    reg random_data : UInt<256>, clock with :
      reset => (reset, UInt<256>("h0")) @[memory.scala 36:28]
    reg random_data_fail : UInt<256>, clock with :
      reset => (reset, UInt<256>("h0")) @[memory.scala 37:33]
    node _T = and(io.in_wr, io.in_rd) @[memory.scala 39:20]
    node _T_1 = eq(_T, UInt<1>("h0")) @[memory.scala 39:10]
    node _T_2 = bits(reset, 0, 0) @[memory.scala 39:9]
    node _T_3 = eq(_T_2, UInt<1>("h0")) @[memory.scala 39:9]
    when _T_3 : @[memory.scala 39:9]
      node _T_4 = eq(_T_1, UInt<1>("h0")) @[memory.scala 39:9]
      when _T_4 : @[memory.scala 39:9]
        printf(clock, UInt<1>("h1"), "Assumption failed\n    at memory.scala:39 assume(!(io.in_wr&&io.in_rd))\n") : printf @[memory.scala 39:9]
      assume(clock, _T_1, UInt<1>("h1"), "") : assume @[memory.scala 39:9]
    node _T_5 = eq(io.in_wr_addr, random_addr_cst.out) @[memory.scala 44:34]
    node _T_6 = and(io.in_wr, _T_5) @[memory.scala 44:17]
    node _T_7 = lt(random_addr_cst.out, UInt<2>("h2")) @[memory.scala 44:63]
    node _T_8 = and(_T_6, _T_7) @[memory.scala 44:49]
    when _T_8 : @[memory.scala 44:77]
      random_data <= io.in_data @[memory.scala 45:17]
    else :
      node _T_9 = eq(io.in_wr_addr, random_addr_cst.out) @[memory.scala 46:40]
      node _T_10 = and(io.in_wr, _T_9) @[memory.scala 46:23]
      when _T_10 : @[memory.scala 46:56]
        node _random_data_T = bits(io.in_data, 127, 0) @[memory.scala 47:30]
        node _random_data_T_1 = bits(io.in_data, 255, 128) @[memory.scala 47:57]
        node _random_data_T_2 = cat(_random_data_T, _random_data_T_1) @[memory.scala 47:44]
        random_data <= _random_data_T_2 @[memory.scala 47:17]
    node _T_11 = eq(io.in_wr_addr, random_addr_cst.out) @[memory.scala 53:32]
    node _T_12 = and(io.in_wr, _T_11) @[memory.scala 53:16]
    node _T_13 = eq(random_addr_cst.out, random_addr_fail_cst.out) @[memory.scala 53:61]
    node _T_14 = and(_T_12, _T_13) @[memory.scala 53:47]
    when _T_14 : @[memory.scala 53:82]
      node _random_data_fail_T = bits(io.in_data, 127, 0) @[memory.scala 54:35]
      node _random_data_fail_T_1 = bits(io.in_data, 255, 128) @[memory.scala 54:62]
      node _random_data_fail_T_2 = cat(_random_data_fail_T, _random_data_fail_T_1) @[memory.scala 54:49]
      random_data_fail <= _random_data_fail_T_2 @[memory.scala 54:22]
    else :
      node _T_15 = eq(io.in_wr_addr, random_addr_cst.out) @[memory.scala 55:38]
      node _T_16 = and(io.in_wr, _T_15) @[memory.scala 55:22]
      node _T_17 = lt(random_addr_cst.out, UInt<2>("h2")) @[memory.scala 55:67]
      node _T_18 = and(_T_16, _T_17) @[memory.scala 55:53]
      when _T_18 : @[memory.scala 55:81]
        random_data_fail <= io.in_data @[memory.scala 56:22]
      else :
        node _T_19 = eq(io.in_wr_addr, random_addr_cst.out) @[memory.scala 57:38]
        node _T_20 = and(io.in_wr, _T_19) @[memory.scala 57:22]
        when _T_20 : @[memory.scala 57:54]
          node _random_data_fail_T_3 = bits(io.in_data, 127, 0) @[memory.scala 58:35]
          node _random_data_fail_T_4 = bits(io.in_data, 255, 128) @[memory.scala 58:62]
          node _random_data_fail_T_5 = cat(_random_data_fail_T_3, _random_data_fail_T_4) @[memory.scala 58:49]
          random_data_fail <= _random_data_fail_T_5 @[memory.scala 58:22]
    node _T_21 = eq(io.in_rd_addr, random_addr_cst.out) @[memory.scala 61:32]
    node _T_22 = and(io.in_rd, _T_21) @[memory.scala 61:16]
    when _T_22 : @[memory.scala 61:48]
      node _T_23 = eq(io.out_data, random_data) @[memory.scala 62:23]
      when resetCounter.notChaos : @[memory.scala 62:11]
        node _T_24 = bits(reset, 0, 0) @[memory.scala 62:11]
        node _T_25 = eq(_T_24, UInt<1>("h0")) @[memory.scala 62:11]
        when _T_25 : @[memory.scala 62:11]
          node _T_26 = eq(_T_23, UInt<1>("h0")) @[memory.scala 62:11]
          when _T_26 : @[memory.scala 62:11]
            printf(clock, UInt<1>("h1"), "Assertion failed: \n    at Formal.scala:20 cassert(cond, msg)\n") : printf_1 @[memory.scala 62:11]
          assert(clock, _T_23, UInt<1>("h1"), "") : assert @[memory.scala 62:11]


