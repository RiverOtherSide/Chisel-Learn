FIRRTL version 1.1.0
circuit buffer :
  extmodule ResetCounter :
    input clk : Clock
    input reset : UInt<1>
    output timeSinceReset : UInt<32>
    output notChaos : UInt<1>
    defname = ResetCounter

  module buffer :
    input clock : Clock
    input reset : UInt<1>
    input io_rst_n : UInt<1>
    input io_in_wr : UInt<1>
    input io_in_wdata : UInt<8>
    input io_in_rd : UInt<1>
    output io_out_data : UInt<8>
    output io_out_full : UInt<1>

    inst resetCounter of ResetCounter @[Formal.scala 10:36]
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
    reg wrptr : UInt<2>, clock with :
      reset => (UInt<1>("h0"), wrptr) @[buffer.scala 21:22]
    reg rdptr : UInt<2>, clock with :
      reset => (UInt<1>("h0"), rdptr) @[buffer.scala 22:22]
    node _pdiff_T = add(wrptr, UInt<1>("h1")) @[buffer.scala 25:27]
    node _pdiff_T_1 = tail(_pdiff_T, 1) @[buffer.scala 25:27]
    node _pdiff_T_2 = eq(rdptr, _pdiff_T_1) @[buffer.scala 25:18]
    node pdiff = _pdiff_T_2 @[buffer.scala 23:19 25:9]
    node _T = and(pdiff, io_in_wr) @[buffer.scala 27:14]
    node _T_1 = eq(io_in_rd, UInt<1>("h0")) @[buffer.scala 27:29]
    node _T_2 = and(_T, _T_1) @[buffer.scala 27:26]
    node _T_3 = eq(io_in_wr, UInt<1>("h0")) @[buffer.scala 29:14]
    node _T_4 = and(_T_3, io_in_rd) @[buffer.scala 29:24]
    node _GEN_0 = mux(_T_4, UInt<1>("h0"), out_full) @[buffer.scala 29:36 30:14 18:25]
    node _GEN_1 = mux(_T_2, UInt<1>("h1"), _GEN_0) @[buffer.scala 27:39 28:14]
    node _wrptr_T = lt(wrptr, UInt<2>("h3")) @[buffer.scala 37:23]
    node _wrptr_T_1 = add(wrptr, UInt<1>("h1")) @[buffer.scala 37:41]
    node _wrptr_T_2 = tail(_wrptr_T_1, 1) @[buffer.scala 37:41]
    node _wrptr_T_3 = mux(_wrptr_T, _wrptr_T_2, UInt<2>("h0")) @[buffer.scala 37:17]
    node _GEN_2 = mux(io_in_wr, _wrptr_T_3, wrptr) @[buffer.scala 36:17 37:11 21:22]
    node _rdptr_T = lt(rdptr, UInt<2>("h3")) @[buffer.scala 44:23]
    node _rdptr_T_1 = add(rdptr, UInt<1>("h1")) @[buffer.scala 44:41]
    node _rdptr_T_2 = tail(_rdptr_T_1, 1) @[buffer.scala 44:41]
    node _rdptr_T_3 = mux(_rdptr_T, _rdptr_T_2, UInt<2>("h0")) @[buffer.scala 44:17]
    node _GEN_3 = mux(io_in_rd, _rdptr_T_3, rdptr) @[buffer.scala 43:17 44:11 22:22]
    node _buffer_wrptr = io_in_wdata @[buffer.scala 50:{32,32}]
    node _GEN_4 = mux(eq(UInt<1>("h0"), wrptr), _buffer_wrptr, buffer_0) @[buffer.scala 16:23 50:{32,32}]
    node _GEN_5 = mux(eq(UInt<1>("h1"), wrptr), _buffer_wrptr, buffer_1) @[buffer.scala 16:23 50:{32,32}]
    node _GEN_6 = mux(eq(UInt<2>("h2"), wrptr), _buffer_wrptr, buffer_2) @[buffer.scala 16:23 50:{32,32}]
    node _GEN_7 = mux(eq(UInt<2>("h3"), wrptr), _buffer_wrptr, buffer_3) @[buffer.scala 16:23 50:{32,32}]
    node _GEN_8 = mux(io_in_wr, _GEN_4, buffer_0) @[buffer.scala 50:17 16:23]
    node _GEN_9 = mux(io_in_wr, _GEN_5, buffer_1) @[buffer.scala 50:17 16:23]
    node _GEN_10 = mux(io_in_wr, _GEN_6, buffer_2) @[buffer.scala 50:17 16:23]
    node _GEN_11 = mux(io_in_wr, _GEN_7, buffer_3) @[buffer.scala 50:17 16:23]
    reg out_data : UInt<8>, clock with :
      reset => (UInt<1>("h0"), out_data) @[buffer.scala 52:25]
    node _GEN_12 = validif(eq(UInt<1>("h0"), rdptr), buffer_0) @[buffer.scala 54:{27,27}]
    node _GEN_13 = mux(eq(UInt<1>("h1"), rdptr), buffer_1, _GEN_12) @[buffer.scala 54:{27,27}]
    node _GEN_14 = mux(eq(UInt<2>("h2"), rdptr), buffer_2, _GEN_13) @[buffer.scala 54:{27,27}]
    node _GEN_15 = mux(eq(UInt<2>("h3"), rdptr), buffer_3, _GEN_14) @[buffer.scala 54:{27,27}]
    node _buffer_rdptr = _GEN_15 @[buffer.scala 54:27]
    node _GEN_16 = mux(io_in_rd, _buffer_rdptr, out_data) @[buffer.scala 54:17 52:25 54:27]
    node _buffer_WIRE_0 = UInt<8>("h0") @[buffer.scala 16:{43,43}]
    node _buffer_WIRE_1 = UInt<8>("h0") @[buffer.scala 16:{43,43}]
    node _buffer_WIRE_2 = UInt<8>("h0") @[buffer.scala 16:{43,43}]
    node _buffer_WIRE_3 = UInt<8>("h0") @[buffer.scala 16:{43,43}]
    io_out_data <= out_data @[buffer.scala 53:15]
    io_out_full <= out_full @[buffer.scala 19:15]
    resetCounter.clk <= clock @[Formal.scala 11:23]
    resetCounter.reset <= reset @[Formal.scala 12:25]
    buffer_0 <= mux(reset, _buffer_WIRE_0, _GEN_8) @[buffer.scala 16:{23,23}]
    buffer_1 <= mux(reset, _buffer_WIRE_1, _GEN_9) @[buffer.scala 16:{23,23}]
    buffer_2 <= mux(reset, _buffer_WIRE_2, _GEN_10) @[buffer.scala 16:{23,23}]
    buffer_3 <= mux(reset, _buffer_WIRE_3, _GEN_11) @[buffer.scala 16:{23,23}]
    out_full <= mux(reset, UInt<1>("h0"), _GEN_1) @[buffer.scala 18:{25,25}]
    wrptr <= mux(reset, UInt<2>("h0"), _GEN_2) @[buffer.scala 21:{22,22}]
    rdptr <= mux(reset, UInt<2>("h0"), _GEN_3) @[buffer.scala 22:{22,22}]
    out_data <= mux(reset, UInt<8>("h0"), _GEN_16) @[buffer.scala 52:{25,25}]
