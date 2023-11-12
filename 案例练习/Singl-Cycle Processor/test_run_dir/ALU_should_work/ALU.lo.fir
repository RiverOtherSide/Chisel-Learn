FIRRTL version 1.1.0
circuit ALU :
  module ALU :
    input clock : Clock
    input reset : UInt<1>
    input io_SrcA : SInt<32>
    input io_SrcB : SInt<32>
    input io_ALUControl : UInt<3>
    output io_ALUResult : SInt<32>

    node _T = eq(UInt<3>("h0"), io_ALUControl) @[ALU.scala 16:24]
    node _result_T = add(io_SrcA, io_SrcB) @[ALU.scala 17:30]
    node _result_T_1 = tail(_result_T, 1) @[ALU.scala 17:30]
    node _result_T_2 = asSInt(_result_T_1) @[ALU.scala 17:30]
    node _T_1 = eq(UInt<3>("h1"), io_ALUControl) @[ALU.scala 16:24]
    node _result_T_3 = sub(io_SrcA, io_SrcB) @[ALU.scala 18:30]
    node _result_T_4 = tail(_result_T_3, 1) @[ALU.scala 18:30]
    node _result_T_5 = asSInt(_result_T_4) @[ALU.scala 18:30]
    node _T_2 = eq(UInt<3>("h2"), io_ALUControl) @[ALU.scala 16:24]
    node _result_T_6 = and(io_SrcA, io_SrcB) @[ALU.scala 19:31]
    node _result_T_7 = asSInt(_result_T_6) @[ALU.scala 19:31]
    node _T_3 = eq(UInt<3>("h3"), io_ALUControl) @[ALU.scala 16:24]
    node _result_T_8 = or(io_SrcA, io_SrcB) @[ALU.scala 20:30]
    node _result_T_9 = asSInt(_result_T_8) @[ALU.scala 20:30]
    node _T_4 = eq(UInt<3>("h5"), io_ALUControl) @[ALU.scala 16:24]
    node _T_5 = lt(io_SrcA, io_SrcB) @[ALU.scala 22:25]
    node _GEN_0 = mux(_T_5, asSInt(UInt<2>("h1")), asSInt(UInt<1>("h0"))) @[ALU.scala 22:{34,42,67}]
    node _GEN_1 = mux(_T_4, _GEN_0, io_SrcA) @[ALU.scala 16:24 13:27]
    node _GEN_2 = mux(_T_3, _result_T_9, _GEN_1) @[ALU.scala 16:24 20:19]
    node _GEN_3 = mux(_T_2, _result_T_7, _GEN_2) @[ALU.scala 16:24 19:20]
    node _GEN_4 = mux(_T_1, _result_T_5, _GEN_3) @[ALU.scala 16:24 18:20]
    node _GEN_5 = mux(_T, _result_T_2, _GEN_4) @[ALU.scala 16:24 17:20]
    node result = _GEN_5 @[ALU.scala 13:27]
    io_ALUResult <= result @[ALU.scala 15:16]
