module adder(
  input        clock,
  input        reset,
  input  [7:0] io_a,
  input  [7:0] io_b,
  output [7:0] io_o
);
  wire [15:0] _io_o_T = $signed(io_a) * $signed(io_b); // @[adder.scala 13:24]
  assign io_o = _io_o_T[7:0]; // @[adder.scala 15:8]
endmodule
