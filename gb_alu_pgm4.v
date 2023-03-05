module gb_alu_pgm4 (
	input wire [3:0] i_g,
	input wire [3:0] i_p,

	output wire o_gm,
	output wire o_pm
);

	assign o_gm = i_g[3]
				| i_g[2] & i_p[3]
				| i_g[1] & i_p[3] & i_p[2]
				| i_g[0] & i_p[3] & i_p[2] & i_p[1];

	assign o_pm = i_p[3] & i_p[2] & i_p[1] & i_p[0];

endmodule