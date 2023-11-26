circuit buffer :
  extmodule ResetCounter :
    input clk : Clock
    input reset : UInt<1>
    output timeSinceReset : UInt<32>
    output notChaos : UInt<1>
    defname = ResetCounter

  extmodule AnyConst :
    output out : UInt<1>
    defname = AnyConst
    parameter WIDTH = 1

  module buffer :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip rst_n : UInt<1>, flip in_wr : UInt<1>, flip in_wdata : UInt<8>, flip in_rd : UInt<1>, out_data : UInt<8>, out_empty : UInt<1>, out_full : UInt<1>}

    inst resetCounter of ResetCounter @[Formal.scala 10:36]
    resetCounter.clk <= clock @[Formal.scala 11:23]
    resetCounter.reset <= reset @[Formal.scala 12:25]
    wire _buffer_WIRE : UInt<8>[4] @[buffer.scala 16:43]
    _buffer_WIRE[0] <= UInt<8>("h0") @[buffer.scala 16:43]
    _buffer_WIRE[1] <= UInt<8>("h0") @[buffer.scala 16:43]
    _buffer_WIRE[2] <= UInt<8>("h0") @[buffer.scala 16:43]
    _buffer_WIRE[3] <= UInt<8>("h0") @[buffer.scala 16:43]
    reg buffer : UInt<8>[4], clock with :
      reset => (reset, _buffer_WIRE) @[buffer.scala 16:23]
    reg out_full : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[buffer.scala 18:25]
    io.out_full <= out_full @[buffer.scala 19:15]
    reg out_empty : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[buffer.scala 20:26]
    io.out_empty <= out_empty @[buffer.scala 21:16]
    reg out_data : UInt<8>, clock with :
      reset => (reset, UInt<8>("h0")) @[buffer.scala 22:25]
    io.out_data <= out_data @[buffer.scala 23:15]
    reg wrptr : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[buffer.scala 25:22]
    reg rdptr : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[buffer.scala 26:22]
    wire pdiff : UInt<1> @[buffer.scala 27:19]
    node _pdiff_T = add(wrptr, UInt<1>("h1")) @[buffer.scala 29:27]
    node _pdiff_T_1 = tail(_pdiff_T, 1) @[buffer.scala 29:27]
    node _pdiff_T_2 = eq(rdptr, _pdiff_T_1) @[buffer.scala 29:18]
    pdiff <= _pdiff_T_2 @[buffer.scala 29:9]
    node _T = and(pdiff, io.in_wr) @[buffer.scala 31:14]
    node _T_1 = eq(io.in_rd, UInt<1>("h0")) @[buffer.scala 31:29]
    node _T_2 = and(_T, _T_1) @[buffer.scala 31:26]
    when _T_2 : @[buffer.scala 31:39]
      out_full <= UInt<1>("h1") @[buffer.scala 32:14]
    else :
      node _T_3 = eq(io.in_wr, UInt<1>("h0")) @[buffer.scala 33:14]
      node _T_4 = and(_T_3, io.in_rd) @[buffer.scala 33:24]
      when _T_4 : @[buffer.scala 33:36]
        out_full <= UInt<1>("h0") @[buffer.scala 34:14]
    node _out_empty_T = eq(wrptr, rdptr) @[buffer.scala 37:22]
    node _out_empty_T_1 = eq(out_full, UInt<1>("h0")) @[buffer.scala 37:36]
    node _out_empty_T_2 = and(_out_empty_T, _out_empty_T_1) @[buffer.scala 37:32]
    out_empty <= _out_empty_T_2 @[buffer.scala 37:13]
    when io.in_wr : @[buffer.scala 39:17]
      node _wrptr_T = lt(wrptr, UInt<2>("h3")) @[buffer.scala 40:23]
      node _wrptr_T_1 = add(wrptr, UInt<1>("h1")) @[buffer.scala 40:41]
      node _wrptr_T_2 = tail(_wrptr_T_1, 1) @[buffer.scala 40:41]
      node _wrptr_T_3 = mux(_wrptr_T, _wrptr_T_2, UInt<2>("h0")) @[buffer.scala 40:17]
      wrptr <= _wrptr_T_3 @[buffer.scala 40:11]
    when io.in_rd : @[buffer.scala 43:17]
      node _rdptr_T = lt(rdptr, UInt<2>("h3")) @[buffer.scala 44:23]
      node _rdptr_T_1 = add(rdptr, UInt<1>("h1")) @[buffer.scala 44:41]
      node _rdptr_T_2 = tail(_rdptr_T_1, 1) @[buffer.scala 44:41]
      node _rdptr_T_3 = mux(_rdptr_T, _rdptr_T_2, UInt<2>("h0")) @[buffer.scala 44:17]
      rdptr <= _rdptr_T_3 @[buffer.scala 44:11]
    when io.in_wr : @[buffer.scala 47:17]
      buffer[wrptr] <= io.in_wdata @[buffer.scala 47:32]
    when io.in_rd : @[buffer.scala 48:17]
      out_data <= buffer[rdptr] @[buffer.scala 48:27]
    node _T_5 = eq(io.in_wr, UInt<1>("h0")) @[buffer.scala 51:22]
    node _T_6 = and(out_full, _T_5) @[buffer.scala 51:19]
    node _T_7 = bits(reset, 0, 0) @[buffer.scala 51:9]
    node _T_8 = eq(_T_7, UInt<1>("h0")) @[buffer.scala 51:9]
    when _T_8 : @[buffer.scala 51:9]
      node _T_9 = eq(_T_6, UInt<1>("h0")) @[buffer.scala 51:9]
      when _T_9 : @[buffer.scala 51:9]
        printf(clock, UInt<1>("h1"), "Assumption failed\n    at buffer.scala:51 assume(out_full && !io.in_wr)\n") : printf @[buffer.scala 51:9]
      assume(clock, _T_6, UInt<1>("h1"), "") : assume @[buffer.scala 51:9]
    node _T_10 = eq(io.in_rd, UInt<1>("h0")) @[buffer.scala 52:23]
    node _T_11 = and(out_empty, _T_10) @[buffer.scala 52:20]
    node _T_12 = bits(reset, 0, 0) @[buffer.scala 52:9]
    node _T_13 = eq(_T_12, UInt<1>("h0")) @[buffer.scala 52:9]
    when _T_13 : @[buffer.scala 52:9]
      node _T_14 = eq(_T_11, UInt<1>("h0")) @[buffer.scala 52:9]
      when _T_14 : @[buffer.scala 52:9]
        printf(clock, UInt<1>("h1"), "Assumption failed\n    at buffer.scala:52 assume(out_empty && !io.in_rd)\n") : printf_1 @[buffer.scala 52:9]
      assume(clock, _T_11, UInt<1>("h1"), "") : assume_1 @[buffer.scala 52:9]
    reg flag : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[buffer.scala 55:21]
    inst rnd_mark_cst of AnyConst @[Formal.scala 93:21]
    wire mark_vld : UInt<1> @[buffer.scala 57:29]
    mark_vld <= UInt<1>("h0") @[buffer.scala 57:29]
    wire check_vld : UInt<1> @[buffer.scala 58:30]
    check_vld <= UInt<1>("h0") @[buffer.scala 58:30]
    node _mark_vld_T = bits(rnd_mark_cst.out, 0, 0) @[buffer.scala 60:36]
    node _mark_vld_T_1 = and(io.in_wr, _mark_vld_T) @[buffer.scala 60:24]
    mark_vld <= _mark_vld_T_1 @[buffer.scala 60:12]
    node _check_vld_T = eq(io.out_data, UInt<1>("h0")) @[buffer.scala 61:41]
    node _check_vld_T_1 = and(io.in_rd, _check_vld_T) @[buffer.scala 61:25]
    check_vld <= _check_vld_T_1 @[buffer.scala 61:13]
    when check_vld : @[buffer.scala 63:18]
      flag <= UInt<1>("h0") @[buffer.scala 64:10]
    else :
      when mark_vld : @[buffer.scala 65:23]
        flag <= UInt<1>("h1") @[buffer.scala 66:10]
    when mark_vld : @[buffer.scala 73:17]
      node _T_15 = eq(io.in_wdata, UInt<1>("h1")) @[buffer.scala 74:23]
      node _T_16 = bits(reset, 0, 0) @[buffer.scala 74:11]
      node _T_17 = eq(_T_16, UInt<1>("h0")) @[buffer.scala 74:11]
      when _T_17 : @[buffer.scala 74:11]
        node _T_18 = eq(_T_15, UInt<1>("h0")) @[buffer.scala 74:11]
        when _T_18 : @[buffer.scala 74:11]
          printf(clock, UInt<1>("h1"), "Assumption failed\n    at buffer.scala:74 assume(io.in_wdata===1.U)\n") : printf_2 @[buffer.scala 74:11]
        assume(clock, _T_15, UInt<1>("h1"), "") : assume_2 @[buffer.scala 74:11]
    else :
      when io.in_wr : @[buffer.scala 76:19]
        node _T_19 = eq(io.in_wdata, UInt<1>("h0")) @[buffer.scala 77:25]
        node _T_20 = bits(reset, 0, 0) @[buffer.scala 77:13]
        node _T_21 = eq(_T_20, UInt<1>("h0")) @[buffer.scala 77:13]
        when _T_21 : @[buffer.scala 77:13]
          node _T_22 = eq(_T_19, UInt<1>("h0")) @[buffer.scala 77:13]
          when _T_22 : @[buffer.scala 77:13]
            printf(clock, UInt<1>("h1"), "Assumption failed\n    at buffer.scala:77 assume(io.in_wdata===0.U)\n") : printf_3 @[buffer.scala 77:13]
          assume(clock, _T_19, UInt<1>("h1"), "") : assume_3 @[buffer.scala 77:13]
    when flag : @[buffer.scala 80:13]
      node _T_23 = eq(mark_vld, UInt<1>("h0")) @[buffer.scala 81:12]
      node _T_24 = bits(reset, 0, 0) @[buffer.scala 81:11]
      node _T_25 = eq(_T_24, UInt<1>("h0")) @[buffer.scala 81:11]
      when _T_25 : @[buffer.scala 81:11]
        node _T_26 = eq(_T_23, UInt<1>("h0")) @[buffer.scala 81:11]
        when _T_26 : @[buffer.scala 81:11]
          printf(clock, UInt<1>("h1"), "Assumption failed\n    at buffer.scala:81 assume(!mark_vld)\n") : printf_4 @[buffer.scala 81:11]
        assume(clock, _T_23, UInt<1>("h1"), "") : assume_4 @[buffer.scala 81:11]
    node _T_27 = and(check_vld, flag) @[buffer.scala 84:20]
    when resetCounter.notChaos : @[buffer.scala 84:9]
      node _T_28 = bits(reset, 0, 0) @[buffer.scala 84:9]
      node _T_29 = eq(_T_28, UInt<1>("h0")) @[buffer.scala 84:9]
      when _T_29 : @[buffer.scala 84:9]
        node _T_30 = eq(_T_27, UInt<1>("h0")) @[buffer.scala 84:9]
        when _T_30 : @[buffer.scala 84:9]
          printf(clock, UInt<1>("h1"), "Assertion failed: \n    at Formal.scala:20 cassert(cond, msg)\n") : printf_5 @[buffer.scala 84:9]
        assert(clock, _T_27, UInt<1>("h1"), "") : assert @[buffer.scala 84:9]


