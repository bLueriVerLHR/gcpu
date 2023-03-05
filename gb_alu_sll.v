module gb_alu_sll (
    input [6:0] i_shamt,
    input [63:0] i_base,

    output [63:0] o_sll
);
    wire [63:0] sll_01 = |{i_shamt & 7'b0000001} ? {i_base[62:0],  1'b0} : i_base;
    wire [63:0] sll_02 = |{i_shamt & 7'b0000010} ? {sll_01[61:0],  2'b0} : sll_01;
    wire [63:0] sll_04 = |{i_shamt & 7'b0000100} ? {sll_02[59:0],  4'b0} : sll_02;
    wire [63:0] sll_08 = |{i_shamt & 7'b0001000} ? {sll_04[55:0],  8'b0} : sll_04;
    wire [63:0] sll_16 = |{i_shamt & 7'b0010000} ? {sll_08[47:0], 16'b0} : sll_08;
    wire [63:0] sll_32 = |{i_shamt & 7'b0100000} ? {sll_16[31:0], 32'b0} : sll_16;
    wire [63:0] sll_64 = |{i_shamt & 7'b1000000} ? {              64'b0} : sll_32;

    assign o_sll = sll_64;
endmodule