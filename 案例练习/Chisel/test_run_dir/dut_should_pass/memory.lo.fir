FIRRTL version 1.1.0
circuit memory :
  extmodule ResetCounter :
    input clk : Clock
    input reset : UInt<1>
    output timeSinceReset : UInt<32>
    output notChaos : UInt<1>
    defname = ResetCounter

  module memory :
    input clock : Clock
    input reset : UInt<1>
    input io_rst_n : UInt<1>
    input io_in_wr : UInt<1>
    input io_in_rd : UInt<1>
    input io_in_data : UInt<256>
    input io_in_wr_addr : UInt<5>
    input io_in_rd_addr : UInt<5>
    output io_out_data : UInt<256>

    inst resetCounter of ResetCounter @[Formal.scala 10:36]
    reg mem_0 : UInt<256>, clock with :
      reset => (UInt<1>("h0"), mem_0) @[memory.scala 17:16]
    reg mem_1 : UInt<256>, clock with :
      reset => (UInt<1>("h0"), mem_1) @[memory.scala 17:16]
    reg mem_2 : UInt<256>, clock with :
      reset => (UInt<1>("h0"), mem_2) @[memory.scala 17:16]
    reg mem_3 : UInt<256>, clock with :
      reset => (UInt<1>("h0"), mem_3) @[memory.scala 17:16]
    node _T = eq(io_rst_n, UInt<1>("h0")) @[memory.scala 19:8]
    node _T_1 = bits(io_in_wr_addr, 1, 0)
    node _mem_T = lt(io_in_wr_addr, UInt<2>("h2")) @[memory.scala 24:44]
    node _mem_T_1 = bits(io_in_data, 127, 0) @[memory.scala 24:78]
    node _mem_T_2 = bits(io_in_data, 255, 128) @[memory.scala 24:103]
    node _mem_T_3 = cat(_mem_T_1, _mem_T_2) @[memory.scala 24:91]
    node _mem_T_4 = mux(_mem_T, io_in_data, _mem_T_3) @[memory.scala 24:30]
    node _mem_T_1_0 = _mem_T_4 @[memory.scala 24:{24,24}]
    node _GEN_0 = mux(eq(UInt<1>("h0"), _T_1), _mem_T_1_0, mem_0) @[memory.scala 17:16 24:{24,24}]
    node _GEN_1 = mux(eq(UInt<1>("h1"), _T_1), _mem_T_1_0, mem_1) @[memory.scala 17:16 24:{24,24}]
    node _GEN_2 = mux(eq(UInt<2>("h2"), _T_1), _mem_T_1_0, mem_2) @[memory.scala 17:16 24:{24,24}]
    node _GEN_3 = mux(eq(UInt<2>("h3"), _T_1), _mem_T_1_0, mem_3) @[memory.scala 17:16 24:{24,24}]
    node _GEN_4 = mux(io_in_wr, _GEN_0, mem_0) @[memory.scala 17:16 23:23]
    node _GEN_5 = mux(io_in_wr, _GEN_1, mem_1) @[memory.scala 17:16 23:23]
    node _GEN_6 = mux(io_in_wr, _GEN_2, mem_2) @[memory.scala 17:16 23:23]
    node _GEN_7 = mux(io_in_wr, _GEN_3, mem_3) @[memory.scala 17:16 23:23]
    node _GEN_8 = mux(_T, UInt<1>("h0"), _GEN_4) @[memory.scala 19:18 21:14]
    node _GEN_9 = mux(_T, UInt<1>("h0"), _GEN_5) @[memory.scala 19:18 21:14]
    node _GEN_10 = mux(_T, UInt<1>("h0"), _GEN_6) @[memory.scala 19:18 21:14]
    node _GEN_11 = mux(_T, UInt<1>("h0"), _GEN_7) @[memory.scala 19:18 21:14]
    node _io_out_data_T = bits(io_in_rd_addr, 1, 0)
    node _GEN_12 = validif(eq(UInt<1>("h0"), _io_out_data_T), mem_0) @[memory.scala 28:{17,17}]
    node _GEN_13 = mux(eq(UInt<1>("h1"), _io_out_data_T), mem_1, _GEN_12) @[memory.scala 28:{17,17}]
    node _GEN_14 = mux(eq(UInt<2>("h2"), _io_out_data_T), mem_2, _GEN_13) @[memory.scala 28:{17,17}]
    node _GEN_15 = mux(eq(UInt<2>("h3"), _io_out_data_T), mem_3, _GEN_14) @[memory.scala 28:{17,17}]
    node _mem_io_out_data_T = _GEN_15 @[memory.scala 28:17]
    node _GEN_16 = mux(io_in_rd, _mem_io_out_data_T, UInt<1>("h0")) @[memory.scala 27:17 28:17 30:17]
    io_out_data <= _GEN_16
    resetCounter.clk <= clock @[Formal.scala 11:23]
    resetCounter.reset <= reset @[Formal.scala 12:25]
    mem_0 <= _GEN_8
    mem_1 <= _GEN_9
    mem_2 <= _GEN_10
    mem_3 <= _GEN_11
