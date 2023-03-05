module gb_alu_clu4 (
	input wire [3:0] i_g,
	input wire [3:0] i_p,

	input wire i_c,

	output wire [3:0] o_c
);
							
	assign o_c[0] =                                                       i_g[0] |                            i_c & i_p[0];
	assign o_c[1] =                            i_g[1] |                   i_g[0] & i_p[1] |                   i_c & i_p[1] & i_p[0];
	assign o_c[2] =          i_g[2] |          i_g[1] & i_p[2] |          i_g[0] & i_p[2] & i_p[1] |          i_c & i_p[2] & i_p[1] & i_p[0];
	assign o_c[3] = i_g[3] | i_g[2] & i_p[3] | i_g[1] & i_p[3] & i_p[2] | i_g[0] & i_p[3] & i_p[2] & i_p[1] | i_c & i_p[3] & i_p[2] & i_p[1] & i_p[0];

endmodule