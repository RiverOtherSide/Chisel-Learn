FIRRTL version 1.1.0
circuit memory :
  module memory :
    input clock : Clock
    input reset : UInt<1>
    input io_a : UInt<32>
    input io_wd : SInt<32>
    input io_we : UInt<1>
    output io_rd : SInt<32>

    mem mem : @[memory.scala 12:24]
      data-type => SInt<32>
      depth => 1024
      read-latency => 1
      write-latency => 1
      reader => io_rd_MPORT
      writer => MPORT
      read-under-write => undefined
    node _GEN_0 = validif(UInt<1>("h1"), io_a) @[memory.scala 14:{20,20}]
    node _io_rd_WIRE = _GEN_0 @[memory.scala 14:20]
    node _io_rd_T = or(_io_rd_WIRE, UInt<10>("h0")) @[memory.scala 14:20]
    node _io_rd_T_1 = bits(_io_rd_T, 9, 0) @[memory.scala 14:20]
    node _GEN_1 = mux(UInt<1>("h1"), UInt<1>("h1"), UInt<1>("h0")) @[memory.scala 14:{20,20} 12:24]
    node _GEN_2 = validif(UInt<1>("h1"), _io_rd_T_1) @[memory.scala 14:{20,20}]
    node _GEN_3 = validif(UInt<1>("h1"), clock) @[memory.scala 14:{20,20}]
    node _T = bits(io_a, 9, 0)
    node _GEN_4 = validif(io_we, _T) @[memory.scala 15:15]
    node _GEN_5 = validif(io_we, clock) @[memory.scala 15:15]
    node _GEN_6 = mux(io_we, UInt<1>("h1"), UInt<1>("h0")) @[memory.scala 15:15 12:24]
    node _GEN_7 = validif(io_we, UInt<1>("h1")) @[memory.scala 15:15]
    node _GEN_8 = validif(io_we, io_wd) @[memory.scala 15:15]
    io_rd <= mem.io_rd_MPORT.data @[memory.scala 14:9]
    mem.io_rd_MPORT.addr <= _GEN_2
    mem.io_rd_MPORT.en <= _GEN_1
    mem.io_rd_MPORT.clk <= _GEN_3
    mem.MPORT.addr <= _GEN_4
    mem.MPORT.en <= _GEN_6
    mem.MPORT.clk <= _GEN_5
    mem.MPORT.data <= _GEN_8
    mem.MPORT.mask <= _GEN_7
