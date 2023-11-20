module counter(
  input        clock,
  input        reset,
  output [7:0] io_count
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  resetCounter_clk; // @[Formal.scala 10:36]
  wire  resetCounter_reset; // @[Formal.scala 10:36]
  wire [31:0] resetCounter_timeSinceReset; // @[Formal.scala 10:36]
  wire  resetCounter_notChaos; // @[Formal.scala 10:36]
  reg [7:0] count; // @[counter.scala 9:22]
  wire [7:0] _count_T_1 = count + 8'h1; // @[counter.scala 10:18]
  wire  _T_3 = ~reset; // @[counter.scala 15:9]
  wire  _T_5 = count == 8'h0; // @[counter.scala 17:23]
  wire  _T_10 = ~(count == 8'h0); // @[counter.scala 17:11]
  ResetCounter resetCounter ( // @[Formal.scala 10:36]
    .clk(resetCounter_clk),
    .reset(resetCounter_reset),
    .timeSinceReset(resetCounter_timeSinceReset),
    .notChaos(resetCounter_notChaos)
  );
  assign io_count = count; // @[counter.scala 14:12]
  assign resetCounter_clk = clock; // @[Formal.scala 11:23]
  assign resetCounter_reset = reset; // @[Formal.scala 12:25]
  always @(posedge clock) begin
    if (reset) begin // @[counter.scala 9:22]
      count <= 8'h0; // @[counter.scala 9:22]
    end else if (count == 8'ha) begin // @[counter.scala 11:29]
      count <= 8'h0; // @[counter.scala 12:11]
    end else begin
      count <= _count_T_1; // @[counter.scala 10:9]
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (resetCounter_notChaos & ~reset & ~(count < 8'hb)) begin
          $fwrite(32'h80000002,"Assertion failed: \n    at Formal.scala:20 cassert(cond, msg)\n"); // @[counter.scala 15:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (resetCounter_notChaos & resetCounter_timeSinceReset == 32'h0 & _T_3 & ~(count == 8'h0)) begin
          $fwrite(32'h80000002,"Assertion failed: \n    at Formal.scala:28 cassert(cond, msg)\n"); // @[counter.scala 17:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (resetCounter_notChaos & resetCounter_timeSinceReset == 32'h1 & _T_3 & ~(count == 8'h1)) begin
          $fwrite(32'h80000002,"Assertion failed: \n    at Formal.scala:28 cassert(cond, msg)\n"); // @[counter.scala 18:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (resetCounter_notChaos & resetCounter_timeSinceReset == 32'h2 & _T_3 & ~(count == 8'h2)) begin
          $fwrite(32'h80000002,"Assertion failed: \n    at Formal.scala:28 cassert(cond, msg)\n"); // @[counter.scala 19:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (resetCounter_notChaos & resetCounter_timeSinceReset == 32'h3 & _T_3 & ~(count == 8'h3)) begin
          $fwrite(32'h80000002,"Assertion failed: \n    at Formal.scala:28 cassert(cond, msg)\n"); // @[counter.scala 20:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (resetCounter_notChaos & resetCounter_timeSinceReset == 32'h4 & _T_3 & ~(count == 8'h4)) begin
          $fwrite(32'h80000002,"Assertion failed: \n    at Formal.scala:28 cassert(cond, msg)\n"); // @[counter.scala 21:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (resetCounter_notChaos & resetCounter_timeSinceReset == 32'hb & _T_3 & _T_10) begin
          $fwrite(32'h80000002,"Assertion failed: \n    at Formal.scala:28 cassert(cond, msg)\n"); // @[counter.scala 22:11]
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
  count = _RAND_0[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    //
    if (resetCounter_notChaos & ~reset) begin
      assert(count < 8'hb); // @[counter.scala 15:9]
    end
    //
    if (resetCounter_notChaos & resetCounter_timeSinceReset == 32'h0 & _T_3) begin
      assert(count == 8'h0); // @[counter.scala 17:11]
    end
    //
    if (resetCounter_notChaos & resetCounter_timeSinceReset == 32'h1 & _T_3) begin
      assert(count == 8'h1); // @[counter.scala 18:11]
    end
    //
    if (resetCounter_notChaos & resetCounter_timeSinceReset == 32'h2 & _T_3) begin
      assert(count == 8'h2); // @[counter.scala 19:11]
    end
    //
    if (resetCounter_notChaos & resetCounter_timeSinceReset == 32'h3 & _T_3) begin
      assert(count == 8'h3); // @[counter.scala 20:11]
    end
    //
    if (resetCounter_notChaos & resetCounter_timeSinceReset == 32'h4 & _T_3) begin
      assert(count == 8'h4); // @[counter.scala 21:11]
    end
    //
    if (resetCounter_notChaos & resetCounter_timeSinceReset == 32'hb & _T_3) begin
      assert(_T_5); // @[counter.scala 22:11]
    end
  end
endmodule
