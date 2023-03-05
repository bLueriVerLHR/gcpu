module gb_alu_pg #(
	LEN = 4
) (
	input wire [LEN-1:0] i_a,
	input wire [LEN-1:0] i_b,

	output wire [LEN-1:0] o_g,
	output wire [LEN-1:0] o_p
);
	
    assign o_g = i_a & i_b;
	assign o_p = i_a | i_b;

endmodule