// Slider puzzle reduced to 2 rows and four columns. +----+----+----+----+
//                                                   |  0 |  1 |  2 |  3 |
// The entries of the matrix are numbered thus:      +----+----+----+----+
//                                                   |  4 |  5 |  6 |  7 |
// Author: Fabio Somenzi <Fabio@Colorado.EDU>        +----+----+----+----+

module twoByFour(clock,from,to);
    input       clock;
    input [2:0] from;
    input [2:0] to;

    reg [2:0] 	b[0:7];
    reg [2:0] 	freg, treg;
    wire 	valid, parity;

    initial begin
	b[0]  = 7; b[1]  = 6; b[2]  = 5; b[3]  = 4;
	b[4]  = 3; b[5]  = 2; b[6]  = 1; b[7]  = 0;
	treg = 0;
	freg = 0;
    end // initial begin

    assign valid = (b[treg] == 3'b000) &&
		   (((treg[1:0] == freg[1:0]) && !(treg[2] == freg[2])) ||
		    ((treg[2] == freg[2]) &&
		     (((treg[1:0]==2'b00) && (freg[1:0]==2'b01)) ||
		      ((treg[1:0]==2'b01) && (freg[0]==0)) ||
		      ((treg[1:0]==2'b10) && (freg[0]==1)) ||
		      ((treg[1:0]==2'b11) && (freg[1:0]==2'b10))
		      )
		     )
		    );

    assign parity = 
	   (((b[0] & 5) == 1) | ((b[0] & 5) == 4)) ^
	   (((b[1] & 5) == 0) | ((b[1] & 5) == 5)) ^
	   (((b[2] & 5) == 1) | ((b[2] & 5) == 4)) ^
	   (((b[3] & 5) == 0) | ((b[3] & 5) == 5)) ^
	   (((b[4] & 5) == 1) | ((b[4] & 5) == 4)) ^
	   (((b[5] & 5) == 0) | ((b[5] & 5) == 5)) ^
	   (((b[6] & 5) == 1) | ((b[6] & 5) == 4)) ^
	   (((b[7] & 5) == 0) | ((b[7] & 5) == 5));

    always @ (posedge clock) begin
	freg = from;
	treg = to;
    end

    always @ (posedge clock) begin
	if (valid) begin
	    b[treg] = b[freg];
	    b[freg] = 0;
	end
    end

endmodule // twoByFour
