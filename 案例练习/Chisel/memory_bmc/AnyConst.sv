
module AnyConst #(parameter WIDTH) (
    output [WIDTH-1:0] out
);

(* anyconst *) reg [WIDTH-1:0] cst;
assign out = cst;

endmodule
