module gb_alu_srl (
    input [6:0] i_shamt,
    input [63:0] i_base,

    output [63:0] o_srl
);
    wire [63:0] srl_01 = |{i_shamt & 7'b0000001} ? { 1'b0, i_base[63: 1]} : i_base;
    wire [63:0] srl_02 = |{i_shamt & 7'b0000010} ? { 2'b0, srl_01[63: 2]} : srl_01;
    wire [63:0] srl_04 = |{i_shamt & 7'b0000100} ? { 4'b0, srl_02[63: 4]} : srl_02;
    wire [63:0] srl_08 = |{i_shamt & 7'b0001000} ? { 8'b0, srl_04[63: 8]} : srl_04;
    wire [63:0] srl_16 = |{i_shamt & 7'b0010000} ? {16'b0, srl_08[63:16]} : srl_08;
    wire [63:0] srl_32 = |{i_shamt & 7'b0100000} ? {32'b0, srl_16[63:32]} : srl_16;
    wire [63:0] srl_64 = |{i_shamt & 7'b1000000} ? {64'b0               } : srl_32;

    assign o_srl = srl_64;
endmodule