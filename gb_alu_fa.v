module gb_alu_fa (
    input wire i_a,
    input wire i_b,
    input wire i_c,

    output wire o_s,
    output wire o_c
);

    assign o_s = i_a ^ i_b ^ i_c;
    assign o_c = (i_a & i_b) | (i_a & i_c) | (i_b & i_c);

endmodule