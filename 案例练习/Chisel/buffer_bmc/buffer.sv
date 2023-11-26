module buffer(
  input        clock,
  input        reset,
  input        io_rst_n,
  input        io_in_wr,
  input  [7:0] io_in_wdata,
  input        io_in_rd,
  output [7:0] io_out_data,
  output       io_out_empty,
  output       io_out_full
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
`endif // RANDOMIZE_REG_INIT
  wire  resetCounter_clk; // @[Formal.scala 10:36]
  wire  resetCounter_reset; // @[Formal.scala 10:36]
  wire [31:0] resetCounter_timeSinceReset; // @[Formal.scala 10:36]
  wire  resetCounter_notChaos; // @[Formal.scala 10:36]
  wire  rnd_mark_cst_out; // @[Formal.scala 93:21]
  reg [7:0] buffer_0; // @[buffer.scala 16:23]
  reg [7:0] buffer_1; // @[buffer.scala 16:23]
  reg [7:0] buffer_2; // @[buffer.scala 16:23]
  reg [7:0] buffer_3; // @[buffer.scala 16:23]
  reg  out_full; // @[buffer.scala 18:25]
  reg  out_empty; // @[buffer.scala 20:26]
  reg [7:0] out_data; // @[buffer.scala 22:25]
  reg [1:0] wrptr; // @[buffer.scala 25:22]
  reg [1:0] rdptr; // @[buffer.scala 26:22]
  wire [1:0] _pdiff_T_1 = wrptr + 2'h1; // @[buffer.scala 29:27]
  wire  pdiff = rdptr == _pdiff_T_1; // @[buffer.scala 29:18]
  wire  _T_1 = ~io_in_rd; // @[buffer.scala 31:29]
  wire  _T_3 = ~io_in_wr; // @[buffer.scala 33:14]
  wire  _GEN_0 = ~io_in_wr & io_in_rd ? 1'h0 : out_full; // @[buffer.scala 33:36 34:14 18:25]
  wire  _GEN_1 = pdiff & io_in_wr & ~io_in_rd | _GEN_0; // @[buffer.scala 31:39 32:14]
  wire [1:0] _rdptr_T_2 = rdptr + 2'h1; // @[buffer.scala 44:41]
  wire [7:0] _GEN_13 = 2'h1 == rdptr ? buffer_1 : buffer_0; // @[buffer.scala 48:{27,27}]
  wire  _T_8 = ~reset; // @[buffer.scala 51:9]
  reg  flag; // @[buffer.scala 55:21]
  wire  mark_vld = io_in_wr & rnd_mark_cst_out; // @[buffer.scala 60:24]
  wire  check_vld = io_in_rd & io_out_data == 8'h0; // @[buffer.scala 61:25]
  wire  _GEN_17 = mark_vld | flag; // @[buffer.scala 65:23 66:10 55:21]
  wire  _T_23 = ~mark_vld; // @[buffer.scala 81:12]
  ResetCounter resetCounter ( // @[Formal.scala 10:36]
    .clk(resetCounter_clk),
    .reset(resetCounter_reset),
    .timeSinceReset(resetCounter_timeSinceReset),
    .notChaos(resetCounter_notChaos)
  );
  AnyConst #(.WIDTH(1)) rnd_mark_cst ( // @[Formal.scala 93:21]
    .out(rnd_mark_cst_out)
  );
  assign io_out_data = out_data; // @[buffer.scala 23:15]
  assign io_out_empty = out_empty; // @[buffer.scala 21:16]
  assign io_out_full = out_full; // @[buffer.scala 19:15]
  assign resetCounter_clk = clock; // @[Formal.scala 11:23]
  assign resetCounter_reset = reset; // @[Formal.scala 12:25]
  always @(posedge clock) begin
    if (reset) begin // @[buffer.scala 16:23]
      buffer_0 <= 8'h0; // @[buffer.scala 16:23]
    end else if (io_in_wr) begin // @[buffer.scala 47:17]
      if (2'h0 == wrptr) begin // @[buffer.scala 47:32]
        buffer_0 <= io_in_wdata; // @[buffer.scala 47:32]
      end
    end
    if (reset) begin // @[buffer.scala 16:23]
      buffer_1 <= 8'h0; // @[buffer.scala 16:23]
    end else if (io_in_wr) begin // @[buffer.scala 47:17]
      if (2'h1 == wrptr) begin // @[buffer.scala 47:32]
        buffer_1 <= io_in_wdata; // @[buffer.scala 47:32]
      end
    end
    if (reset) begin // @[buffer.scala 16:23]
      buffer_2 <= 8'h0; // @[buffer.scala 16:23]
    end else if (io_in_wr) begin // @[buffer.scala 47:17]
      if (2'h2 == wrptr) begin // @[buffer.scala 47:32]
        buffer_2 <= io_in_wdata; // @[buffer.scala 47:32]
      end
    end
    if (reset) begin // @[buffer.scala 16:23]
      buffer_3 <= 8'h0; // @[buffer.scala 16:23]
    end else if (io_in_wr) begin // @[buffer.scala 47:17]
      if (2'h3 == wrptr) begin // @[buffer.scala 47:32]
        buffer_3 <= io_in_wdata; // @[buffer.scala 47:32]
      end
    end
    if (reset) begin // @[buffer.scala 18:25]
      out_full <= 1'h0; // @[buffer.scala 18:25]
    end else begin
      out_full <= _GEN_1;
    end
    if (reset) begin // @[buffer.scala 20:26]
      out_empty <= 1'h0; // @[buffer.scala 20:26]
    end else begin
      out_empty <= wrptr == rdptr & ~out_full; // @[buffer.scala 37:13]
    end
    if (reset) begin // @[buffer.scala 22:25]
      out_data <= 8'h0; // @[buffer.scala 22:25]
    end else if (io_in_rd) begin // @[buffer.scala 48:17]
      if (2'h3 == rdptr) begin // @[buffer.scala 48:27]
        out_data <= buffer_3; // @[buffer.scala 48:27]
      end else if (2'h2 == rdptr) begin // @[buffer.scala 48:27]
        out_data <= buffer_2; // @[buffer.scala 48:27]
      end else begin
        out_data <= _GEN_13;
      end
    end
    if (reset) begin // @[buffer.scala 25:22]
      wrptr <= 2'h0; // @[buffer.scala 25:22]
    end else if (io_in_wr) begin // @[buffer.scala 39:17]
      if (wrptr < 2'h3) begin // @[buffer.scala 40:17]
        wrptr <= _pdiff_T_1;
      end else begin
        wrptr <= 2'h0;
      end
    end
    if (reset) begin // @[buffer.scala 26:22]
      rdptr <= 2'h0; // @[buffer.scala 26:22]
    end else if (io_in_rd) begin // @[buffer.scala 43:17]
      if (rdptr < 2'h3) begin // @[buffer.scala 44:17]
        rdptr <= _rdptr_T_2;
      end else begin
        rdptr <= 2'h0;
      end
    end
    if (reset) begin // @[buffer.scala 55:21]
      flag <= 1'h0; // @[buffer.scala 55:21]
    end else if (check_vld) begin // @[buffer.scala 63:18]
      flag <= 1'h0; // @[buffer.scala 64:10]
    end else begin
      flag <= _GEN_17;
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (~reset & ~(out_full & _T_3)) begin
          $fwrite(32'h80000002,"Assumption failed\n    at buffer.scala:51 assume(out_full && !io.in_wr)\n"); // @[buffer.scala 51:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_8 & ~(out_empty & _T_1)) begin
          $fwrite(32'h80000002,"Assumption failed\n    at buffer.scala:52 assume(out_empty && !io.in_rd)\n"); // @[buffer.scala 52:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (mark_vld & _T_8 & ~(io_in_wdata == 8'h1)) begin
          $fwrite(32'h80000002,"Assumption failed\n    at buffer.scala:74 assume(io.in_wdata===1.U)\n"); // @[buffer.scala 74:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_23 & io_in_wr & _T_8 & ~(io_in_wdata == 8'h0)) begin
          $fwrite(32'h80000002,"Assumption failed\n    at buffer.scala:77 assume(io.in_wdata===0.U)\n"); // @[buffer.scala 77:13]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (flag & _T_8 & ~(~mark_vld)) begin
          $fwrite(32'h80000002,"Assumption failed\n    at buffer.scala:81 assume(!mark_vld)\n"); // @[buffer.scala 81:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (resetCounter_notChaos & _T_8 & ~(check_vld & flag)) begin
          $fwrite(32'h80000002,"Assertion failed: \n    at Formal.scala:20 cassert(cond, msg)\n"); // @[buffer.scala 84:9]
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
  buffer_0 = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  buffer_1 = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  buffer_2 = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  buffer_3 = _RAND_3[7:0];
  _RAND_4 = {1{`RANDOM}};
  out_full = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  out_empty = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  out_data = _RAND_6[7:0];
  _RAND_7 = {1{`RANDOM}};
  wrptr = _RAND_7[1:0];
  _RAND_8 = {1{`RANDOM}};
  rdptr = _RAND_8[1:0];
  _RAND_9 = {1{`RANDOM}};
  flag = _RAND_9[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    //
    if (~reset) begin
      assume(out_full & _T_3); // @[buffer.scala 51:9]
    end
    //
    if (_T_8) begin
      assume(out_empty & _T_1); // @[buffer.scala 52:9]
    end
    //
    if (mark_vld & _T_8) begin
      assume(io_in_wdata == 8'h1); // @[buffer.scala 74:11]
    end
    //
    if (_T_23 & io_in_wr & _T_8) begin
      assume(io_in_wdata == 8'h0); // @[buffer.scala 77:13]
    end
    //
    if (flag & _T_8) begin
      assume(~mark_vld); // @[buffer.scala 81:11]
    end
    //
    if (resetCounter_notChaos & _T_8) begin
      assert(check_vld & flag); // @[buffer.scala 84:9]
    end
  end
endmodule
