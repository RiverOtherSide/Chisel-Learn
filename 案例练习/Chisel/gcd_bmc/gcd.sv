module gcd(
  input        clock,
  input        reset,
  input  [7:0] io_a,
  input  [7:0] io_b,
  output [7:0] io_o,
  output       io_done
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  wire  resetCounter_clk; // @[Formal.scala 10:36]
  wire  resetCounter_reset; // @[Formal.scala 10:36]
  wire [31:0] resetCounter_timeSinceReset; // @[Formal.scala 10:36]
  wire  resetCounter_notChaos; // @[Formal.scala 10:36]
  reg [2:0] lsb; // @[gcd.scala 15:20]
  reg [7:0] x; // @[gcd.scala 16:16]
  reg [7:0] y; // @[gcd.scala 16:16]
  reg  start; // @[gcd.scala 17:22]
  wire [7:0] _x_lsb_T = x >> lsb; // @[gcd.scala 23:13]
  wire  x_lsb = _x_lsb_T[0]; // @[gcd.scala 23:13]
  wire [7:0] _y_lsb_T = y >> lsb; // @[gcd.scala 24:13]
  wire  y_lsb = _y_lsb_T[0]; // @[gcd.scala 24:13]
  wire  _diff_T = x < y; // @[gcd.scala 25:16]
  wire [7:0] _diff_T_2 = y - x; // @[gcd.scala 25:20]
  wire [7:0] _diff_T_4 = x - y; // @[gcd.scala 25:24]
  wire [7:0] diff = x < y ? _diff_T_2 : _diff_T_4; // @[gcd.scala 25:14]
  wire  _io_done_T = x == y; // @[gcd.scala 27:16]
  wire  _io_done_T_1 = x == 8'h0; // @[gcd.scala 27:25]
  wire  _io_done_T_3 = y == 8'h0; // @[gcd.scala 27:36]
  wire [1:0] _T_6 = {x_lsb,y_lsb}; // @[gcd.scala 36:18]
  wire [2:0] _lsb_T_1 = lsb + 3'h1; // @[gcd.scala 37:29]
  wire [7:0] _x_T = {{1'd0}, x[7:1]}; // @[gcd.scala 38:23]
  wire [7:0] _y_T = {{1'd0}, y[7:1]}; // @[gcd.scala 39:23]
  wire [7:0] _y_T_1 = {{1'd0}, diff[7:1]}; // @[gcd.scala 42:18]
  wire [7:0] _GEN_0 = _diff_T ? _y_T_1 : y; // @[gcd.scala 41:18 42:12 16:16]
  wire [7:0] _GEN_1 = _diff_T ? x : _y_T_1; // @[gcd.scala 16:16 41:18 44:12]
  wire [7:0] _GEN_2 = 2'h3 == _T_6 ? _GEN_0 : y; // @[gcd.scala 16:16 36:27]
  wire [7:0] _GEN_3 = 2'h3 == _T_6 ? _GEN_1 : x; // @[gcd.scala 16:16 36:27]
  wire [7:0] _GEN_4 = 2'h2 == _T_6 ? _y_T : _GEN_2; // @[gcd.scala 36:27 39:20]
  wire [7:0] _GEN_5 = 2'h2 == _T_6 ? x : _GEN_3; // @[gcd.scala 16:16 36:27]
  wire  _GEN_16 = start ? 1'h0 : start; // @[gcd.scala 31:15 34:11 17:22]
  wire  _T_15 = io_a == 8'h6 & io_b == 8'h4 & io_done; // @[gcd.scala 49:33]
  wire  _T_18 = ~reset; // @[gcd.scala 50:11]
  ResetCounter resetCounter ( // @[Formal.scala 10:36]
    .clk(resetCounter_clk),
    .reset(resetCounter_reset),
    .timeSinceReset(resetCounter_timeSinceReset),
    .notChaos(resetCounter_notChaos)
  );
  assign io_o = _diff_T ? x : y; // @[gcd.scala 28:14]
  assign io_done = x == y | x == 8'h0 | y == 8'h0; // @[gcd.scala 27:32]
  assign resetCounter_clk = clock; // @[Formal.scala 11:23]
  assign resetCounter_reset = reset; // @[Formal.scala 12:25]
  always @(posedge clock) begin
    if (reset) begin // @[gcd.scala 15:20]
      lsb <= 3'h0; // @[gcd.scala 15:20]
    end else if (!(start)) begin // @[gcd.scala 31:15]
      if (~_io_done_T | _io_done_T_1 | _io_done_T_3) begin // @[gcd.scala 35:45]
        if (2'h0 == _T_6) begin // @[gcd.scala 36:27]
          lsb <= _lsb_T_1; // @[gcd.scala 37:23]
        end
      end
    end
    if (start) begin // @[gcd.scala 31:15]
      x <= io_a; // @[gcd.scala 32:7]
    end else if (~_io_done_T | _io_done_T_1 | _io_done_T_3) begin // @[gcd.scala 35:45]
      if (!(2'h0 == _T_6)) begin // @[gcd.scala 36:27]
        if (2'h1 == _T_6) begin // @[gcd.scala 36:27]
          x <= _x_T; // @[gcd.scala 38:20]
        end else begin
          x <= _GEN_5;
        end
      end
    end
    if (start) begin // @[gcd.scala 31:15]
      y <= io_b; // @[gcd.scala 33:7]
    end else if (~_io_done_T | _io_done_T_1 | _io_done_T_3) begin // @[gcd.scala 35:45]
      if (!(2'h0 == _T_6)) begin // @[gcd.scala 36:27]
        if (!(2'h1 == _T_6)) begin // @[gcd.scala 36:27]
          y <= _GEN_4;
        end
      end
    end
    start <= reset | _GEN_16; // @[gcd.scala 17:{22,22}]
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_15 & resetCounter_notChaos & ~reset & ~(io_o == 8'h18)) begin
          $fwrite(32'h80000002,"Assertion failed: \n    at Formal.scala:20 cassert(cond, msg)\n"); // @[gcd.scala 50:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (io_done & resetCounter_notChaos & _T_18 & ~io_done) begin
          $fwrite(32'h80000002,"Assertion failed: \n    at Formal.scala:20 cassert(cond, msg)\n"); // @[gcd.scala 59:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  lsb = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  x = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  y = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  start = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    //
    if (_T_15 & resetCounter_notChaos & ~reset) begin
      assert(io_o == 8'h18); // @[gcd.scala 50:11]
    end
    //
    if (io_done & resetCounter_notChaos & _T_18) begin
      assert(io_done); // @[gcd.scala 59:11]
    end
  end
endmodule
