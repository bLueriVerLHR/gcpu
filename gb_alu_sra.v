module gb_alu_sra (
    input [6:0] i_shamt,
    input [63:0] i_base,

    output [63:0] o_sra
);
    wire [63:0] sra_01 = |{i_shamt & 7'b0000001} ? {{ 1{i_base[63]}}, i_base[63: 1]} : i_base;
    wire [63:0] sra_02 = |{i_shamt & 7'b0000010} ? {{ 2{i_base[63]}}, sra_01[63: 2]} : sra_01;
    wire [63:0] sra_04 = |{i_shamt & 7'b0000100} ? {{ 4{i_base[63]}}, sra_02[63: 4]} : sra_02;
    wire [63:0] sra_08 = |{i_shamt & 7'b0001000} ? {{ 8{i_base[63]}}, sra_04[63: 8]} : sra_04;
    wire [63:0] sra_16 = |{i_shamt & 7'b0010000} ? {{16{i_base[63]}}, sra_08[63:16]} : sra_08;
    wire [63:0] sra_32 = |{i_shamt & 7'b0100000} ? {{32{i_base[63]}}, sra_16[63:32]} : sra_16;
    wire [63:0] sra_64 = |{i_shamt & 7'b1000000} ? {{64{i_base[63]}}               } : sra_32;

    assign o_sra = sra_64;
endmodule