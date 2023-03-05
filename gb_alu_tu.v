module gb_alu_tu #(
	LEN = 4
) (
    input wire [LEN-1:0] i_g,
    input wire [LEN-1:0] i_p,

    output wire [LEN-1:0] o_t
);
	
	assign o_t = ~i_g & i_p;
	
endmodule