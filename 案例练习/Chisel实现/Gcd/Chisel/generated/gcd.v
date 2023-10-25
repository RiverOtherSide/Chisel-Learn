module gcd(
  input        clock,
  input        reset,
  input  [7:0] io_a,
  input  [7:0] io_b,
  input        io_start,
  output [7:0] io_o
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] lsb; // @[main.scala 15:20]
  reg [7:0] x; // @[main.scala 16:18]
  reg [7:0] y; // @[main.scala 17:18]
  reg  busy; // @[main.scala 18:21]
  wire [7:0] _io_o_T_1 = io_a > io_b ? io_b : io_a; // @[main.scala 31:13]
  wire [7:0] _x_lsb_T = x >> lsb; // @[main.scala 33:13]
  wire  x_lsb = _x_lsb_T[0]; // @[main.scala 33:13]
  wire [7:0] _y_lsb_T = y >> lsb; // @[main.scala 34:13]
  wire  y_lsb = _y_lsb_T[0]; // @[main.scala 34:13]
  wire  _diff_T = x < y; // @[main.scala 35:16]
  wire [7:0] _diff_T_2 = y - x; // @[main.scala 35:20]
  wire [7:0] _diff_T_4 = x - y; // @[main.scala 35:24]
  wire [7:0] diff = x < y ? _diff_T_2 : _diff_T_4; // @[main.scala 35:14]
  wire  done = (x == y | x == 8'h0 | y == 8'h0) & busy; // @[main.scala 37:42]
  wire [1:0] _T_2 = {x_lsb,y_lsb}; // @[main.scala 44:18]
  wire [2:0] _lsb_T_1 = lsb + 3'h1; // @[main.scala 45:29]
  wire [7:0] _x_T = {{1'd0}, x[7:1]}; // @[main.scala 46:23]
  wire [7:0] _y_T = {{1'd0}, y[7:1]}; // @[main.scala 47:23]
  wire [7:0] _y_T_1 = {{1'd0}, diff[7:1]}; // @[main.scala 50:18]
  wire [7:0] _GEN_0 = _diff_T ? _y_T_1 : y; // @[main.scala 49:18 50:12 17:18]
  wire [7:0] _GEN_1 = _diff_T ? x : _y_T_1; // @[main.scala 16:18 49:18 52:12]
  wire [7:0] _GEN_2 = 2'h3 == _T_2 ? _GEN_0 : y; // @[main.scala 17:18 44:27]
  wire [7:0] _GEN_3 = 2'h3 == _T_2 ? _GEN_1 : x; // @[main.scala 16:18 44:27]
  wire [7:0] _GEN_4 = 2'h2 == _T_2 ? _y_T : _GEN_2; // @[main.scala 44:27 47:20]
  wire [7:0] _GEN_5 = 2'h2 == _T_2 ? x : _GEN_3; // @[main.scala 16:18 44:27]
  wire [7:0] _GEN_6 = 2'h1 == _T_2 ? _x_T : _GEN_5; // @[main.scala 44:27 46:20]
  wire [7:0] _GEN_7 = 2'h1 == _T_2 ? y : _GEN_4; // @[main.scala 17:18 44:27]
  wire [7:0] _io_o_T_3 = _diff_T ? x : y; // @[main.scala 56:16]
  wire [7:0] _GEN_11 = done ? _io_o_T_3 : _io_o_T_1; // @[main.scala 55:20 56:10 31:7]
  wire [7:0] _GEN_15 = busy & ~done ? _io_o_T_1 : _GEN_11; // @[main.scala 43:27 31:7]
  wire  _load_T = ~busy; // @[main.scala 59:24]
  wire  load = io_start & ~busy; // @[main.scala 59:20]
  wire  _GEN_20 = io_start | busy; // @[main.scala 62:19 18:21 62:24]
  assign io_o = load ? _io_o_T_1 : _GEN_15; // @[main.scala 39:13 31:7]
  always @(posedge clock) begin
    if (reset) begin // @[main.scala 15:20]
      lsb <= 3'h0; // @[main.scala 15:20]
    end else if (load) begin // @[main.scala 39:13]
      lsb <= 3'h0; // @[main.scala 42:9]
    end else if (busy & ~done) begin // @[main.scala 43:27]
      if (2'h0 == _T_2) begin // @[main.scala 44:27]
        lsb <= _lsb_T_1; // @[main.scala 45:23]
      end
    end
    if (reset) begin // @[main.scala 16:18]
      x <= 8'h0; // @[main.scala 16:18]
    end else if (load) begin // @[main.scala 39:13]
      x <= io_a; // @[main.scala 40:7]
    end else if (busy & ~done) begin // @[main.scala 43:27]
      if (!(2'h0 == _T_2)) begin // @[main.scala 44:27]
        x <= _GEN_6;
      end
    end
    if (reset) begin // @[main.scala 17:18]
      y <= 8'h0; // @[main.scala 17:18]
    end else if (load) begin // @[main.scala 39:13]
      y <= io_b; // @[main.scala 41:7]
    end else if (busy & ~done) begin // @[main.scala 43:27]
      if (!(2'h0 == _T_2)) begin // @[main.scala 44:27]
        y <= _GEN_7;
      end
    end
    if (reset) begin // @[main.scala 18:21]
      busy <= 1'h0; // @[main.scala 18:21]
    end else if (_load_T) begin // @[main.scala 61:14]
      busy <= _GEN_20;
    end else if (done) begin // @[main.scala 64:15]
      busy <= 1'h0; // @[main.scala 64:20]
    end
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
  busy = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
