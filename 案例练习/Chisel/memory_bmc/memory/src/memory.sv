module memory(
  input          clock,
  input          reset,
  input          io_rst_n,
  input          io_in_wr,
  input          io_in_rd,
  input  [255:0] io_in_data,
  input  [1:0]   io_in_wr_addr,
  input  [1:0]   io_in_rd_addr,
  output [255:0] io_out_data
);
`ifdef RANDOMIZE_REG_INIT
  reg [255:0] _RAND_0;
  reg [255:0] _RAND_1;
  reg [255:0] _RAND_2;
  reg [255:0] _RAND_3;
  reg [255:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  wire  resetCounter_clk; // @[Formal.scala 10:36]
  wire  resetCounter_reset; // @[Formal.scala 10:36]
  wire [31:0] resetCounter_timeSinceReset; // @[Formal.scala 10:36]
  wire  resetCounter_notChaos; // @[Formal.scala 10:36]
  wire [1:0] random_addr_cst_out; // @[Formal.scala 93:21]
  wire [1:0] random_addr_fail_cst_out; // @[Formal.scala 93:21]
  reg [255:0] mem_0; // @[memory.scala 20:20]
  reg [255:0] mem_1; // @[memory.scala 20:20]
  reg [255:0] mem_2; // @[memory.scala 20:20]
  reg [255:0] mem_3; // @[memory.scala 20:20]
  wire [255:0] _mem_T_3 = {io_in_data[127:0],io_in_data[255:128]}; // @[memory.scala 29:91]
  wire [255:0] _GEN_9 = 2'h1 == io_in_rd_addr ? mem_1 : mem_0; // @[memory.scala 32:{15,15}]
  wire [255:0] _GEN_10 = 2'h2 == io_in_rd_addr ? mem_2 : _GEN_9; // @[memory.scala 32:{15,15}]
  reg [255:0] random_data; // @[memory.scala 36:28]
  wire  _T_3 = ~reset; // @[memory.scala 39:9]
  wire  _T_6 = io_in_wr & io_in_wr_addr == random_addr_cst_out; // @[memory.scala 44:17]
  wire  _T_22 = io_in_rd & io_in_rd_addr == random_addr_cst_out; // @[memory.scala 61:16]
  ResetCounter resetCounter ( // @[Formal.scala 10:36]
    .clk(resetCounter_clk),
    .reset(resetCounter_reset),
    .timeSinceReset(resetCounter_timeSinceReset),
    .notChaos(resetCounter_notChaos)
  );
  AnyConst #(.WIDTH(2)) random_addr_cst ( // @[Formal.scala 93:21]
    .out(random_addr_cst_out)
  );
  AnyConst #(.WIDTH(2)) random_addr_fail_cst ( // @[Formal.scala 93:21]
    .out(random_addr_fail_cst_out)
  );
  assign io_out_data = 2'h3 == io_in_rd_addr ? mem_3 : _GEN_10; // @[memory.scala 32:{15,15}]
  assign resetCounter_clk = clock; // @[Formal.scala 11:23]
  assign resetCounter_reset = reset; // @[Formal.scala 12:25]
  always @(posedge clock) begin
    if (reset) begin // @[memory.scala 20:20]
      mem_0 <= 256'h0; // @[memory.scala 20:20]
    end else if (io_in_wr) begin // @[memory.scala 28:17]
      if (2'h0 == io_in_wr_addr) begin // @[memory.scala 29:24]
        if (io_in_wr_addr < 2'h2) begin // @[memory.scala 29:30]
          mem_0 <= io_in_data;
        end else begin
          mem_0 <= _mem_T_3;
        end
      end
    end
    if (reset) begin // @[memory.scala 20:20]
      mem_1 <= 256'h0; // @[memory.scala 20:20]
    end else if (io_in_wr) begin // @[memory.scala 28:17]
      if (2'h1 == io_in_wr_addr) begin // @[memory.scala 29:24]
        if (io_in_wr_addr < 2'h2) begin // @[memory.scala 29:30]
          mem_1 <= io_in_data;
        end else begin
          mem_1 <= _mem_T_3;
        end
      end
    end
    if (reset) begin // @[memory.scala 20:20]
      mem_2 <= 256'h0; // @[memory.scala 20:20]
    end else if (io_in_wr) begin // @[memory.scala 28:17]
      if (2'h2 == io_in_wr_addr) begin // @[memory.scala 29:24]
        if (io_in_wr_addr < 2'h2) begin // @[memory.scala 29:30]
          mem_2 <= io_in_data;
        end else begin
          mem_2 <= _mem_T_3;
        end
      end
    end
    if (reset) begin // @[memory.scala 20:20]
      mem_3 <= 256'h0; // @[memory.scala 20:20]
    end else if (io_in_wr) begin // @[memory.scala 28:17]
      if (2'h3 == io_in_wr_addr) begin // @[memory.scala 29:24]
        if (io_in_wr_addr < 2'h2) begin // @[memory.scala 29:30]
          mem_3 <= io_in_data;
        end else begin
          mem_3 <= _mem_T_3;
        end
      end
    end
    if (reset) begin // @[memory.scala 36:28]
      random_data <= 256'h0; // @[memory.scala 36:28]
    end else if (io_in_wr & io_in_wr_addr == random_addr_cst_out & random_addr_cst_out < 2'h2) begin // @[memory.scala 44:77]
      random_data <= io_in_data; // @[memory.scala 45:17]
    end else if (_T_6) begin // @[memory.scala 46:56]
      random_data <= _mem_T_3; // @[memory.scala 47:17]
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (~reset & ~(~(io_in_wr & io_in_rd))) begin
          $fwrite(32'h80000002,"Assumption failed\n    at memory.scala:39 assume(!(io.in_wr&&io.in_rd))\n"); // @[memory.scala 39:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_22 & resetCounter_notChaos & _T_3 & ~(io_out_data == random_data)) begin
          $fwrite(32'h80000002,"Assertion failed: \n    at Formal.scala:20 cassert(cond, msg)\n"); // @[memory.scala 62:11]
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
  _RAND_0 = {8{`RANDOM}};
  mem_0 = _RAND_0[255:0];
  _RAND_1 = {8{`RANDOM}};
  mem_1 = _RAND_1[255:0];
  _RAND_2 = {8{`RANDOM}};
  mem_2 = _RAND_2[255:0];
  _RAND_3 = {8{`RANDOM}};
  mem_3 = _RAND_3[255:0];
  _RAND_4 = {8{`RANDOM}};
  random_data = _RAND_4[255:0];
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
      assume(~(io_in_wr & io_in_rd)); // @[memory.scala 39:9]
    end
    //
    if (_T_22 & resetCounter_notChaos & _T_3) begin
      assert(io_out_data == random_data); // @[memory.scala 62:11]
    end
  end
endmodule
