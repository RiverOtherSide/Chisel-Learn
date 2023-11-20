`ifndef VERILATOR
module testbench;
  reg [4095:0] vcdfile;
  reg clock;
`else
module testbench(input clock, output reg genclock);
  initial genclock = 1;
`endif
  reg genclock = 1;
  reg [31:0] cycle = 0;
  wire [0:0] PI_clock = clock;
  reg [7:0] PI_io_b;
  reg [0:0] PI_reset;
  reg [7:0] PI_io_a;
  gcd UUT (
    .clock(PI_clock),
    .io_b(PI_io_b),
    .reset(PI_reset),
    .io_a(PI_io_a)
  );
`ifndef VERILATOR
  initial begin
    if ($value$plusargs("vcd=%s", vcdfile)) begin
      $dumpfile(vcdfile);
      $dumpvars(0, testbench);
    end
    #5 clock = 0;
    while (genclock) begin
      #5 clock = 0;
      #5 clock = 1;
    end
  end
`endif
  initial begin
`ifndef VERILATOR
    #1;
`endif
    // UUT.$formal$gcd.\sv:165$1_EN  = 1'b0;
    // UUT.$formal$gcd.\sv:169$2_EN  = 1'b0;
    UUT._witness_.anyinit_procdff_122 = 1'b0;
    UUT._witness_.anyinit_procdff_124 = 1'b0;
    UUT.lsb = 3'b011;
    UUT.resetCounter.count = 32'b00000000000000000000000000000000;
    UUT.resetCounter.flag = 1'b0;
    UUT.start = 1'b0;
    UUT.x = 8'b01001100;
    UUT.y = 8'b00011001;

    // state 0
    PI_io_b = 8'b00011001;
    PI_reset = 1'b1;
    PI_io_a = 8'b11111110;
  end
  always @(posedge clock) begin
    // state 1
    if (cycle == 0) begin
      PI_io_b <= 8'b00000100;
      PI_reset <= 1'b0;
      PI_io_a <= 8'b00000110;
    end

    // state 2
    if (cycle == 1) begin
      PI_io_b <= 8'b00000000;
      PI_reset <= 1'b0;
      PI_io_a <= 8'b00000000;
    end

    genclock <= cycle < 2;
    cycle <= cycle + 1;
  end
endmodule
