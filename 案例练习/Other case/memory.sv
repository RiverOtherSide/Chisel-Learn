module TOP #(parameter WIDTH = 256, PSIZE = 5, DEPTH = 2**PSIZE) (
    input clk,
    input rst_n,
    input in_wr,
    input in_rd ,
    input [WIDTH-1:0] in_data,
    input [PSIZE-1:0] in_wr_addr ,
    input [PSIZE-1:0] in_rd_addr ,
    output reg [WIDTH-1:0] out_data
);

integer i;
reg [WIDTH-1:0] mem [DEPTH-1:0];

always @(posedge clk) begin
    if(~rst_n) begin
        for(i=0; i<DEPTH; i++) begin
            mem[i] <= {WIDTH{1'b0}};
        end	   
    end else if(in_wr) begin
	if(in_wr_addr<(DEPTH/2)) begin
	    mem[in_wr_addr] <= in_data;
 	end else begin
	    mem[in_wr_addr] <= {in_data[WIDTH/2-1:0],in_data[WIDTH-1: WIDTH/2]};
	end
    end
end

always @(posedge clk)
    if(~rst_n)
        out_data <=  {WIDTH{1'b0}};
    else if(in_rd)
        out_data <= mem[in_rd_addr];


//assert
reg [PSIZE-1:0] random_addr;
reg [WIDTH-1:0] random_data;
reg [PSIZE-1:0] random_addr_fail;
reg [WIDTH-1:0] random_data_fail;

asm1: assume property(@(posedge clk) $stable(random_addr));
asm1b: assume property(@(posedge clk) $stable(random_addr_fail));
asm2: assume property(@(posedge clk) (in_wr && in_rd) == 0);

always @(posedge clk) begin
    if(~rst_n)
        random_data <= {WIDTH{1'b0}};
    else if(in_wr && (in_wr_addr == random_addr) && (random_addr<(DEPTH/2)))
        random_data <= in_data;
    else if(in_wr && (in_wr_addr == random_addr))
        random_data <= {in_data[WIDTH/2-1: 0],in_data[WIDTH-1: WIDTH/2]};
end

always @(posedge clk) begin
    if(~rst_n)
        random_data_fail <= {WIDTH{1'b0}};
    else if(in_wr && (in_wr_addr == random_addr) && (random_addr == random_addr_fail))
        random_data_fail <= {in_data[WIDTH/2-1: 0],in_data[WIDTH-1: WIDTH/2]};
    else if(in_wr && (in_wr_addr == random_addr) && ( random_addr<(DEPTH/2)))
        random_data_fail <= in_data;
    else if(in_wr && (in_wr_addr == random_addr))
        random_data_fail <= {in_data[WIDTH/2-1: 0],in_data[WIDTH-1: WIDTH/2]};
end


ast1_pass: assert property(@(posedge clk) in_rd && (in_rd_addr == random_addr) |=> out_data == random_data);
ast1_fail: assert property(@(posedge clk) in_rd && (in_rd_addr == random_addr) |=> out_data == random_data_fail);
	
endmodule
