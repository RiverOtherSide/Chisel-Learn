FIRRTL version 1.1.0
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
    input io_rst_n : UInt<1>
    input io_in_wr : UInt<1>
    input io_in_wdata : UInt<8>
    input io_in_rd : UInt<1>
    output io_out_data : UInt<8>
    output io_out_empty : UInt<1>
    output io_out_full : UInt<1>

    inst resetCounter of ResetCounter @[Formal.scala 10:36]
    inst rnd_mark_cst of AnyConst @[Formal.scala 93:21]
    reg buffer_0 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), buffer_0) @[buffer.scala 16:23]
    reg buffer_1 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), buffer_1) @[buffer.scala 16:23]
    reg buffer_2 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), buffer_2) @[buffer.scala 16:23]
    reg buffer_3 : UInt<8>, clock with :
      reset => (UInt<1>("h0"), buffer_3) @[buffer.scala 16:23]
    reg out_full : UInt<1>, clock with :
      reset => (UInt<1>("h0"), out_full) @[buffer.scala 18:25]
    reg out_empty : UInt<1>, clock with :
      reset => (UInt<1>("h0"), out_empty) @[buffer.scala 20:26]
    reg out_data : UInt<8>, clock with :
      reset => (UInt<1>("h0"), out_data) @[buffer.scala 22:25]
    reg wrptr : UInt<2>, clock with :
      reset => (UInt<1>("h0"), wrptr) @[buffer.scala 25:22]
    reg rdptr : UInt<2>, clock with :
      reset => (UInt<1>("h0"), rdptr) @[buffer.scala 26:22]
    node _pdiff_T = add(wrptr, UInt<1>("h1")) @[buffer.scala 29:27]
    node _pdiff_T_1 = tail(_pdiff_T, 1) @[buffer.scala 29:27]
    node _pdiff_T_2 = eq(rdptr, _pdiff_T_1) @[buffer.scala 29:18]
    node pdiff = _pdiff_T_2 @[buffer.scala 27:19 29:9]
    node _T = and(pdiff, io_in_wr) @[buffer.scala 31:14]
    node _T_1 = eq(io_in_rd, UInt<1>("h0")) @[buffer.scala 31:29]
    node _T_2 = and(_T, _T_1) @[buffer.scala 31:26]
    node _T_3 = eq(io_in_wr, UInt<1>("h0")) @[buffer.scala 33:14]
    node _T_4 = and(_T_3, io_in_rd) @[buffer.scala 33:24]
    node _GEN_0 = mux(_T_4, UInt<1>("h0"), out_full) @[buffer.scala 33:36 34:14 18:25]
    node _GEN_1 = mux(_T_2, UInt<1>("h1"), _GEN_0) @[buffer.scala 31:39 32:14]
    node _out_empty_T = eq(wrptr, rdptr) @[buffer.scala 37:22]
    node _out_empty_T_1 = eq(out_full, UInt<1>("h0")) @[buffer.scala 37:36]
    node _out_empty_T_2 = and(_out_empty_T, _out_empty_T_1) @[buffer.scala 37:32]
    node _wrptr_T = lt(wrptr, UInt<2>("h3")) @[buffer.scala 40:23]
    node _wrptr_T_1 = add(wrptr, UInt<1>("h1")) @[buffer.scala 40:41]
    node _wrptr_T_2 = tail(_wrptr_T_1, 1) @[buffer.scala 40:41]
    node _wrptr_T_3 = mux(_wrptr_T, _wrptr_T_2, UInt<2>("h0")) @[buffer.scala 40:17]
    node _GEN_2 = mux(io_in_wr, _wrptr_T_3, wrptr) @[buffer.scala 39:17 40:11 25:22]
    node _rdptr_T = lt(rdptr, UInt<2>("h3")) @[buffer.scala 44:23]
    node _rdptr_T_1 = add(rdptr, UInt<1>("h1")) @[buffer.scala 44:41]
    node _rdptr_T_2 = tail(_rdptr_T_1, 1) @[buffer.scala 44:41]
    node _rdptr_T_3 = mux(_rdptr_T, _rdptr_T_2, UInt<2>("h0")) @[buffer.scala 44:17]
    node _GEN_3 = mux(io_in_rd, _rdptr_T_3, rdptr) @[buffer.scala 43:17 44:11 26:22]
    node _buffer_wrptr = io_in_wdata @[buffer.scala 47:{32,32}]
    node _GEN_4 = mux(eq(UInt<1>("h0"), wrptr), _buffer_wrptr, buffer_0) @[buffer.scala 16:23 47:{32,32}]
    node _GEN_5 = mux(eq(UInt<1>("h1"), wrptr), _buffer_wrptr, buffer_1) @[buffer.scala 16:23 47:{32,32}]
    node _GEN_6 = mux(eq(UInt<2>("h2"), wrptr), _buffer_wrptr, buffer_2) @[buffer.scala 16:23 47:{32,32}]
    node _GEN_7 = mux(eq(UInt<2>("h3"), wrptr), _buffer_wrptr, buffer_3) @[buffer.scala 16:23 47:{32,32}]
    node _GEN_8 = mux(io_in_wr, _GEN_4, buffer_0) @[buffer.scala 47:17 16:23]
    node _GEN_9 = mux(io_in_wr, _GEN_5, buffer_1) @[buffer.scala 47:17 16:23]
    node _GEN_10 = mux(io_in_wr, _GEN_6, buffer_2) @[buffer.scala 47:17 16:23]
    node _GEN_11 = mux(io_in_wr, _GEN_7, buffer_3) @[buffer.scala 47:17 16:23]
    node _GEN_12 = validif(eq(UInt<1>("h0"), rdptr), buffer_0) @[buffer.scala 48:{27,27}]
    node _GEN_13 = mux(eq(UInt<1>("h1"), rdptr), buffer_1, _GEN_12) @[buffer.scala 48:{27,27}]
    node _GEN_14 = mux(eq(UInt<2>("h2"), rdptr), buffer_2, _GEN_13) @[buffer.scala 48:{27,27}]
    node _GEN_15 = mux(eq(UInt<2>("h3"), rdptr), buffer_3, _GEN_14) @[buffer.scala 48:{27,27}]
    node _buffer_rdptr = _GEN_15 @[buffer.scala 48:27]
    node _GEN_16 = mux(io_in_rd, _buffer_rdptr, out_data) @[buffer.scala 48:17 22:25 48:27]
    reg in_rd_ff1 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), in_rd_ff1) @[buffer.scala 54:26]
    reg flag : UInt<1>, clock with :
      reset => (UInt<1>("h0"), flag) @[buffer.scala 55:21]
    node _mark_vld_T = bits(rnd_mark_cst.out, 0, 0) @[buffer.scala 60:36]
    node _mark_vld_T_1 = and(io_in_wr, _mark_vld_T) @[buffer.scala 60:24]
    node _check_vld_T = eq(io_out_data, UInt<1>("h0")) @[buffer.scala 61:42]
    node _check_vld_T_1 = and(in_rd_ff1, _check_vld_T) @[buffer.scala 61:26]
    node mark_vld = _mark_vld_T_1 @[buffer.scala 57:29 60:12]
    node _GEN_17 = mux(mark_vld, UInt<1>("h1"), flag) @[buffer.scala 65:23 66:10 55:21]
    node check_vld = _check_vld_T_1 @[buffer.scala 58:30 61:13]
    node _GEN_18 = mux(check_vld, UInt<1>("h0"), _GEN_17) @[buffer.scala 63:18 64:10]
    node _buffer_WIRE_0 = UInt<8>("h0") @[buffer.scala 16:{43,43}]
    node _buffer_WIRE_1 = UInt<8>("h0") @[buffer.scala 16:{43,43}]
    node _buffer_WIRE_2 = UInt<8>("h0") @[buffer.scala 16:{43,43}]
    node _buffer_WIRE_3 = UInt<8>("h0") @[buffer.scala 16:{43,43}]
    io_out_data <= out_data @[buffer.scala 23:15]
    io_out_empty <= out_empty @[buffer.scala 21:16]
    io_out_full <= out_full @[buffer.scala 19:15]
    resetCounter.clk <= clock @[Formal.scala 11:23]
    resetCounter.reset <= reset @[Formal.scala 12:25]
    buffer_0 <= mux(reset, _buffer_WIRE_0, _GEN_8) @[buffer.scala 16:{23,23}]
    buffer_1 <= mux(reset, _buffer_WIRE_1, _GEN_9) @[buffer.scala 16:{23,23}]
    buffer_2 <= mux(reset, _buffer_WIRE_2, _GEN_10) @[buffer.scala 16:{23,23}]
    buffer_3 <= mux(reset, _buffer_WIRE_3, _GEN_11) @[buffer.scala 16:{23,23}]
    out_full <= mux(reset, UInt<1>("h0"), _GEN_1) @[buffer.scala 18:{25,25}]
    out_empty <= mux(reset, UInt<1>("h0"), _out_empty_T_2) @[buffer.scala 20:{26,26} 37:13]
    out_data <= mux(reset, UInt<8>("h0"), _GEN_16) @[buffer.scala 22:{25,25}]
    wrptr <= mux(reset, UInt<2>("h0"), _GEN_2) @[buffer.scala 25:{22,22}]
    rdptr <= mux(reset, UInt<2>("h0"), _GEN_3) @[buffer.scala 26:{22,22}]
    in_rd_ff1 <= mux(reset, UInt<1>("h0"), io_in_rd) @[buffer.scala 54:{26,26} 62:13]
    flag <= mux(reset, UInt<1>("h0"), _GEN_18) @[buffer.scala 55:{21,21}]
