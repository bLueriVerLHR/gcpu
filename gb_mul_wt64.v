module gb_mul_wt64 (
    input wire [63:0] i_a,
    input wire [63:0] i_b,

    output wire [127:0] o_res
);
    wire [63:0] pdt [63:0];
    wire [66:0] pdt_lvl_1 [15:0][1:0];

    genvar i, j, k;

    generate
        for (i = 0; i < 64; i = i + 1) begin
            assign pdt[i] = i_b[i] ? i_a : 64'b0;
        end
    endgenerate

    wire [66:0] l1_c [15:0];

    generate
        for (k = 0; k < 16; k = k + 1) begin
            gb_mul_42csa csa42_l1_0(.i_x1(pdt[4*k][  0]), .i_x2(           1'b0), .i_x3(           1'b0), .i_x4(          1'b0), .i_e(        1'b0), .o_s(pdt_lvl_1[k][0][  0]), .o_carry(pdt_lvl_1[k][1][  0]), .o_e(l1_c[k][  0]));
            gb_mul_42csa csa42_l1_1(.i_x1(pdt[4*k][  1]), .i_x2(pdt[4*k+1][  0]), .i_x3(           1'b0), .i_x4(          1'b0), .i_e(l1_c[k][  0]), .o_s(pdt_lvl_1[k][0][  1]), .o_carry(pdt_lvl_1[k][1][  1]), .o_e(l1_c[k][  1]));
            gb_mul_42csa csa42_l1_2(.i_x1(pdt[4*k][  2]), .i_x2(pdt[4*k+1][  1]), .i_x3(pdt[4*k+2][  0]), .i_x4(          1'b0), .i_e(l1_c[k][  1]), .o_s(pdt_lvl_1[k][0][  2]), .o_carry(pdt_lvl_1[k][1][  2]), .o_e(l1_c[k][  2]));
        for (j = 0; j < 61; j = j + 1) begin
            gb_mul_42csa csa42_l1_ (.i_x1(pdt[4*k][j+3]), .i_x2(pdt[4*k+1][j+2]), .i_x3(pdt[4*k+2][j+1]), .i_x4(pdt[4*k+3][ j]), .i_e(l1_c[k][j+2]), .o_s(pdt_lvl_1[k][0][j+3]), .o_carry(pdt_lvl_1[k][1][j+3]), .o_e(l1_c[k][j+3]));
        end
            gb_mul_42csa csa42_l1_3(.i_x1(         1'b0), .i_x2(pdt[4*k+1][ 63]), .i_x3(pdt[4*k+2][ 62]), .i_x4(pdt[4*k+3][61]), .i_e(l1_c[k][ 63]), .o_s(pdt_lvl_1[k][0][ 64]), .o_carry(pdt_lvl_1[k][1][ 64]), .o_e(l1_c[k][ 64]));
            gb_mul_42csa csa42_l1_4(.i_x1(         1'b0), .i_x2(           1'b0), .i_x3(pdt[4*k+2][ 63]), .i_x4(pdt[4*k+3][62]), .i_e(l1_c[k][ 64]), .o_s(pdt_lvl_1[k][0][ 65]), .o_carry(pdt_lvl_1[k][1][ 65]), .o_e(l1_c[k][ 65]));
            gb_mul_42csa csa42_l1_5(.i_x1(         1'b0), .i_x2(           1'b0), .i_x3(           1'b0), .i_x4(pdt[4*k+3][63]), .i_e(l1_c[k][ 65]), .o_s(pdt_lvl_1[k][0][ 66]), .o_carry(pdt_lvl_1[k][1][ 66]), .o_e(l1_c[k][ 66]));
        end
    endgenerate

    wire [66:0] pdt1 [31:0];
    wire [71:0] pdt_lvl_2 [7:0][1:0];

    generate
        for (i = 0; i < 16; i = i + 1) begin
            assign pdt1[i * 2 + 0] = pdt_lvl_1[i][0];
            assign pdt1[i * 2 + 1] = pdt_lvl_1[i][1];
        end
    endgenerate

    wire [71:0] l2_c [7:0];

    generate
        for (k = 0; k < 8; k = k + 1) begin
            gb_mul_42csa csa42_l2_0(.i_x1(pdt1[4*k][  0]), .i_x2(            1'b0), .i_x3(            1'b0), .i_x4(           1'b0), .i_e(        1'b0), .o_s(pdt_lvl_2[k][0][  0]), .o_carry(pdt_lvl_2[k][1][  0]), .o_e(l2_c[k][  0]));
            gb_mul_42csa csa42_l2_1(.i_x1(pdt1[4*k][  1]), .i_x2(pdt1[4*k+1][  0]), .i_x3(            1'b0), .i_x4(           1'b0), .i_e(l2_c[k][  0]), .o_s(pdt_lvl_2[k][0][  1]), .o_carry(pdt_lvl_2[k][1][  1]), .o_e(l2_c[k][  1]));
            gb_mul_42csa csa42_l2_2(.i_x1(pdt1[4*k][  2]), .i_x2(pdt1[4*k+1][  1]), .i_x3(            1'b0), .i_x4(           1'b0), .i_e(l2_c[k][  1]), .o_s(pdt_lvl_2[k][0][  2]), .o_carry(pdt_lvl_2[k][1][  2]), .o_e(l2_c[k][  2]));
            gb_mul_42csa csa42_l2_3(.i_x1(pdt1[4*k][  3]), .i_x2(pdt1[4*k+1][  2]), .i_x3(            1'b0), .i_x4(           1'b0), .i_e(l2_c[k][  2]), .o_s(pdt_lvl_2[k][0][  3]), .o_carry(pdt_lvl_2[k][1][  3]), .o_e(l2_c[k][  3]));
            gb_mul_42csa csa42_l2_4(.i_x1(pdt1[4*k][  4]), .i_x2(pdt1[4*k+1][  3]), .i_x3(pdt1[4*k+2][  0]), .i_x4(           1'b0), .i_e(l2_c[k][  3]), .o_s(pdt_lvl_2[k][0][  4]), .o_carry(pdt_lvl_2[k][1][  4]), .o_e(l2_c[k][  4]));
        for (j = 0; j < 62; j = j + 1) begin
            gb_mul_42csa csa42_l2_ (.i_x1(pdt1[4*k][j+5]), .i_x2(pdt1[4*k+1][j+4]), .i_x3(pdt1[4*k+2][j+1]), .i_x4(pdt1[4*k+3][ j]), .i_e(l2_c[k][j+4]), .o_s(pdt_lvl_2[k][0][j+5]), .o_carry(pdt_lvl_2[k][1][j+5]), .o_e(l2_c[k][j+5]));
        end
            gb_mul_42csa csa42_l2_5(.i_x1(          1'b0), .i_x2(pdt1[4*k+1][ 66]), .i_x3(pdt1[4*k+2][ 63]), .i_x4(pdt1[4*k+3][62]), .i_e(l2_c[k][ 66]), .o_s(pdt_lvl_2[k][0][ 67]), .o_carry(pdt_lvl_2[k][1][ 67]), .o_e(l2_c[k][ 67]));
            gb_mul_42csa csa42_l2_6(.i_x1(          1'b0), .i_x2(            1'b0), .i_x3(pdt1[4*k+2][ 64]), .i_x4(pdt1[4*k+3][63]), .i_e(l2_c[k][ 67]), .o_s(pdt_lvl_2[k][0][ 68]), .o_carry(pdt_lvl_2[k][1][ 68]), .o_e(l2_c[k][ 68]));
            gb_mul_42csa csa42_l2_7(.i_x1(          1'b0), .i_x2(            1'b0), .i_x3(pdt1[4*k+2][ 65]), .i_x4(pdt1[4*k+3][64]), .i_e(l2_c[k][ 68]), .o_s(pdt_lvl_2[k][0][ 69]), .o_carry(pdt_lvl_2[k][1][ 69]), .o_e(l2_c[k][ 69]));
            gb_mul_42csa csa42_l2_8(.i_x1(          1'b0), .i_x2(            1'b0), .i_x3(pdt1[4*k+2][ 66]), .i_x4(pdt1[4*k+3][65]), .i_e(l2_c[k][ 69]), .o_s(pdt_lvl_2[k][0][ 70]), .o_carry(pdt_lvl_2[k][1][ 70]), .o_e(l2_c[k][ 70]));
            gb_mul_42csa csa42_l2_9(.i_x1(          1'b0), .i_x2(            1'b0), .i_x3(            1'b0), .i_x4(pdt1[4*k+3][66]), .i_e(l2_c[k][ 70]), .o_s(pdt_lvl_2[k][0][ 71]), .o_carry(pdt_lvl_2[k][1][ 71]), .o_e(l2_c[k][ 71]));
        end
    endgenerate

    wire [71:0] pdt2 [15:0];
    wire [80:0] pdt_lvl_3 [3:0][1:0];

    generate
        for (i = 0; i < 8; i = i + 1) begin
            assign pdt2[i * 2 + 0] = pdt_lvl_2[i][0];
            assign pdt2[i * 2 + 1] = pdt_lvl_2[i][1];
        end
    endgenerate

    wire [80:0] l3_c [3:0];

    generate
        for (k = 0; k < 4; k = k + 1) begin
            gb_mul_42csa csa42_l3_00(.i_x1(pdt2[4*k][  0]), .i_x2(            1'b0), .i_x3(            1'b0), .i_x4(           1'b0), .i_e(        1'b0), .o_s(pdt_lvl_3[k][0][  0]), .o_carry(pdt_lvl_3[k][1][  0]), .o_e(l3_c[k][  0]));
            gb_mul_42csa csa42_l3_01(.i_x1(pdt2[4*k][  1]), .i_x2(pdt2[4*k+1][  0]), .i_x3(            1'b0), .i_x4(           1'b0), .i_e(l3_c[k][  0]), .o_s(pdt_lvl_3[k][0][  1]), .o_carry(pdt_lvl_3[k][1][  1]), .o_e(l3_c[k][  1]));
            gb_mul_42csa csa42_l3_02(.i_x1(pdt2[4*k][  2]), .i_x2(pdt2[4*k+1][  1]), .i_x3(            1'b0), .i_x4(           1'b0), .i_e(l3_c[k][  1]), .o_s(pdt_lvl_3[k][0][  2]), .o_carry(pdt_lvl_3[k][1][  2]), .o_e(l3_c[k][  2]));
            gb_mul_42csa csa42_l3_03(.i_x1(pdt2[4*k][  3]), .i_x2(pdt2[4*k+1][  2]), .i_x3(            1'b0), .i_x4(           1'b0), .i_e(l3_c[k][  2]), .o_s(pdt_lvl_3[k][0][  3]), .o_carry(pdt_lvl_3[k][1][  3]), .o_e(l3_c[k][  3]));
            gb_mul_42csa csa42_l3_04(.i_x1(pdt2[4*k][  4]), .i_x2(pdt2[4*k+1][  3]), .i_x3(            1'b0), .i_x4(           1'b0), .i_e(l3_c[k][  3]), .o_s(pdt_lvl_3[k][0][  4]), .o_carry(pdt_lvl_3[k][1][  4]), .o_e(l3_c[k][  4]));
            gb_mul_42csa csa42_l3_05(.i_x1(pdt2[4*k][  5]), .i_x2(pdt2[4*k+1][  4]), .i_x3(            1'b0), .i_x4(           1'b0), .i_e(l3_c[k][  4]), .o_s(pdt_lvl_3[k][0][  5]), .o_carry(pdt_lvl_3[k][1][  5]), .o_e(l3_c[k][  5]));
            gb_mul_42csa csa42_l3_06(.i_x1(pdt2[4*k][  6]), .i_x2(pdt2[4*k+1][  5]), .i_x3(            1'b0), .i_x4(           1'b0), .i_e(l3_c[k][  5]), .o_s(pdt_lvl_3[k][0][  6]), .o_carry(pdt_lvl_3[k][1][  6]), .o_e(l3_c[k][  6]));
            gb_mul_42csa csa42_l3_07(.i_x1(pdt2[4*k][  7]), .i_x2(pdt2[4*k+1][  6]), .i_x3(            1'b0), .i_x4(           1'b0), .i_e(l3_c[k][  6]), .o_s(pdt_lvl_3[k][0][  7]), .o_carry(pdt_lvl_3[k][1][  7]), .o_e(l3_c[k][  7]));
            gb_mul_42csa csa42_l3_08(.i_x1(pdt2[4*k][  8]), .i_x2(pdt2[4*k+1][  7]), .i_x3(pdt2[4*k+2][  0]), .i_x4(           1'b0), .i_e(l3_c[k][  7]), .o_s(pdt_lvl_3[k][0][  8]), .o_carry(pdt_lvl_3[k][1][  8]), .o_e(l3_c[k][  8]));
        for (j = 0; j < 63; j = j + 1) begin
            gb_mul_42csa csa42_l3_  (.i_x1(pdt2[4*k][j+9]), .i_x2(pdt2[4*k+1][j+8]), .i_x3(pdt2[4*k+2][j+1]), .i_x4(pdt2[4*k+3][ j]), .i_e(l3_c[k][j+8]), .o_s(pdt_lvl_3[k][0][j+9]), .o_carry(pdt_lvl_3[k][1][j+9]), .o_e(l3_c[k][j+9]));
        end
            gb_mul_42csa csa42_l3_09(.i_x1(          1'b0), .i_x2(pdt2[4*k+1][ 71]), .i_x3(pdt2[4*k+2][ 64]), .i_x4(pdt2[4*k+3][63]), .i_e(l3_c[k][ 71]), .o_s(pdt_lvl_3[k][0][ 72]), .o_carry(pdt_lvl_3[k][1][ 72]), .o_e(l3_c[k][ 72]));
            gb_mul_42csa csa42_l3_10(.i_x1(          1'b0), .i_x2(            1'b0), .i_x3(pdt2[4*k+2][ 65]), .i_x4(pdt2[4*k+3][64]), .i_e(l3_c[k][ 72]), .o_s(pdt_lvl_3[k][0][ 73]), .o_carry(pdt_lvl_3[k][1][ 73]), .o_e(l3_c[k][ 73]));
            gb_mul_42csa csa42_l3_11(.i_x1(          1'b0), .i_x2(            1'b0), .i_x3(pdt2[4*k+2][ 66]), .i_x4(pdt2[4*k+3][65]), .i_e(l3_c[k][ 73]), .o_s(pdt_lvl_3[k][0][ 74]), .o_carry(pdt_lvl_3[k][1][ 74]), .o_e(l3_c[k][ 74]));
            gb_mul_42csa csa42_l3_12(.i_x1(          1'b0), .i_x2(            1'b0), .i_x3(pdt2[4*k+2][ 67]), .i_x4(pdt2[4*k+3][66]), .i_e(l3_c[k][ 74]), .o_s(pdt_lvl_3[k][0][ 75]), .o_carry(pdt_lvl_3[k][1][ 75]), .o_e(l3_c[k][ 75]));
            gb_mul_42csa csa42_l3_13(.i_x1(          1'b0), .i_x2(            1'b0), .i_x3(pdt2[4*k+2][ 68]), .i_x4(pdt2[4*k+3][67]), .i_e(l3_c[k][ 75]), .o_s(pdt_lvl_3[k][0][ 76]), .o_carry(pdt_lvl_3[k][1][ 76]), .o_e(l3_c[k][ 76]));
            gb_mul_42csa csa42_l3_14(.i_x1(          1'b0), .i_x2(            1'b0), .i_x3(pdt2[4*k+2][ 69]), .i_x4(pdt2[4*k+3][68]), .i_e(l3_c[k][ 76]), .o_s(pdt_lvl_3[k][0][ 77]), .o_carry(pdt_lvl_3[k][1][ 77]), .o_e(l3_c[k][ 77]));
            gb_mul_42csa csa42_l3_15(.i_x1(          1'b0), .i_x2(            1'b0), .i_x3(pdt2[4*k+2][ 70]), .i_x4(pdt2[4*k+3][69]), .i_e(l3_c[k][ 77]), .o_s(pdt_lvl_3[k][0][ 78]), .o_carry(pdt_lvl_3[k][1][ 78]), .o_e(l3_c[k][ 78]));
            gb_mul_42csa csa42_l3_16(.i_x1(          1'b0), .i_x2(            1'b0), .i_x3(pdt2[4*k+2][ 71]), .i_x4(pdt2[4*k+3][70]), .i_e(l3_c[k][ 78]), .o_s(pdt_lvl_3[k][0][ 79]), .o_carry(pdt_lvl_3[k][1][ 79]), .o_e(l3_c[k][ 79]));
            gb_mul_42csa csa42_l3_17(.i_x1(          1'b0), .i_x2(            1'b0), .i_x3(            1'b0), .i_x4(pdt2[4*k+3][71]), .i_e(l3_c[k][ 79]), .o_s(pdt_lvl_3[k][0][ 80]), .o_carry(pdt_lvl_3[k][1][ 80]), .o_e(l3_c[k][ 80]));
        end
    endgenerate

    wire [80:0] pdt3 [7:0];
    wire [97:0] pdt_lvl_4 [1:0][1:0];

    generate
        for (i = 0; i < 4; i = i + 1) begin
            assign pdt3[i * 2 + 0] = pdt_lvl_3[i][0];
            assign pdt3[i * 2 + 1] = pdt_lvl_3[i][1];
        end
    endgenerate

    wire [97:0] l4_c [1:0];

    generate
        for (k = 0; k < 2; k = k + 1) begin
            gb_mul_42csa csa42_l4_00(.i_x1(pdt3[4*k][   0]), .i_x2(             1'b0), .i_x3(            1'b0), .i_x4(           1'b0), .i_e(         1'b0), .o_s(pdt_lvl_4[k][0][   0]), .o_carry(pdt_lvl_4[k][1][   0]), .o_e(l4_c[k][   0]));
            gb_mul_42csa csa42_l4_01(.i_x1(pdt3[4*k][   1]), .i_x2(pdt3[4*k+1][   0]), .i_x3(            1'b0), .i_x4(           1'b0), .i_e(l4_c[k][   0]), .o_s(pdt_lvl_4[k][0][   1]), .o_carry(pdt_lvl_4[k][1][   1]), .o_e(l4_c[k][   1]));
            gb_mul_42csa csa42_l4_02(.i_x1(pdt3[4*k][   2]), .i_x2(pdt3[4*k+1][   1]), .i_x3(            1'b0), .i_x4(           1'b0), .i_e(l4_c[k][   1]), .o_s(pdt_lvl_4[k][0][   2]), .o_carry(pdt_lvl_4[k][1][   2]), .o_e(l4_c[k][   2]));
            gb_mul_42csa csa42_l4_03(.i_x1(pdt3[4*k][   3]), .i_x2(pdt3[4*k+1][   2]), .i_x3(            1'b0), .i_x4(           1'b0), .i_e(l4_c[k][   2]), .o_s(pdt_lvl_4[k][0][   3]), .o_carry(pdt_lvl_4[k][1][   3]), .o_e(l4_c[k][   3]));
            gb_mul_42csa csa42_l4_04(.i_x1(pdt3[4*k][   4]), .i_x2(pdt3[4*k+1][   3]), .i_x3(            1'b0), .i_x4(           1'b0), .i_e(l4_c[k][   3]), .o_s(pdt_lvl_4[k][0][   4]), .o_carry(pdt_lvl_4[k][1][   4]), .o_e(l4_c[k][   4]));
            gb_mul_42csa csa42_l4_05(.i_x1(pdt3[4*k][   5]), .i_x2(pdt3[4*k+1][   4]), .i_x3(            1'b0), .i_x4(           1'b0), .i_e(l4_c[k][   4]), .o_s(pdt_lvl_4[k][0][   5]), .o_carry(pdt_lvl_4[k][1][   5]), .o_e(l4_c[k][   5]));
            gb_mul_42csa csa42_l4_06(.i_x1(pdt3[4*k][   6]), .i_x2(pdt3[4*k+1][   5]), .i_x3(            1'b0), .i_x4(           1'b0), .i_e(l4_c[k][   5]), .o_s(pdt_lvl_4[k][0][   6]), .o_carry(pdt_lvl_4[k][1][   6]), .o_e(l4_c[k][   6]));
            gb_mul_42csa csa42_l4_07(.i_x1(pdt3[4*k][   7]), .i_x2(pdt3[4*k+1][   6]), .i_x3(            1'b0), .i_x4(           1'b0), .i_e(l4_c[k][   6]), .o_s(pdt_lvl_4[k][0][   7]), .o_carry(pdt_lvl_4[k][1][   7]), .o_e(l4_c[k][   7]));
            gb_mul_42csa csa42_l4_08(.i_x1(pdt3[4*k][   8]), .i_x2(pdt3[4*k+1][   7]), .i_x3(            1'b0), .i_x4(           1'b0), .i_e(l4_c[k][   7]), .o_s(pdt_lvl_4[k][0][   8]), .o_carry(pdt_lvl_4[k][1][   8]), .o_e(l4_c[k][   8]));
            gb_mul_42csa csa42_l4_09(.i_x1(pdt3[4*k][   9]), .i_x2(pdt3[4*k+1][   8]), .i_x3(            1'b0), .i_x4(           1'b0), .i_e(l4_c[k][   8]), .o_s(pdt_lvl_4[k][0][   9]), .o_carry(pdt_lvl_4[k][1][   9]), .o_e(l4_c[k][   9]));
            gb_mul_42csa csa42_l4_10(.i_x1(pdt3[4*k][  10]), .i_x2(pdt3[4*k+1][   9]), .i_x3(            1'b0), .i_x4(           1'b0), .i_e(l4_c[k][   9]), .o_s(pdt_lvl_4[k][0][  10]), .o_carry(pdt_lvl_4[k][1][  10]), .o_e(l4_c[k][  10]));
            gb_mul_42csa csa42_l4_11(.i_x1(pdt3[4*k][  11]), .i_x2(pdt3[4*k+1][  10]), .i_x3(            1'b0), .i_x4(           1'b0), .i_e(l4_c[k][  10]), .o_s(pdt_lvl_4[k][0][  11]), .o_carry(pdt_lvl_4[k][1][  11]), .o_e(l4_c[k][  11]));
            gb_mul_42csa csa42_l4_12(.i_x1(pdt3[4*k][  12]), .i_x2(pdt3[4*k+1][  11]), .i_x3(            1'b0), .i_x4(           1'b0), .i_e(l4_c[k][  11]), .o_s(pdt_lvl_4[k][0][  12]), .o_carry(pdt_lvl_4[k][1][  12]), .o_e(l4_c[k][  12]));
            gb_mul_42csa csa42_l4_13(.i_x1(pdt3[4*k][  13]), .i_x2(pdt3[4*k+1][  12]), .i_x3(            1'b0), .i_x4(           1'b0), .i_e(l4_c[k][  12]), .o_s(pdt_lvl_4[k][0][  13]), .o_carry(pdt_lvl_4[k][1][  13]), .o_e(l4_c[k][  13]));
            gb_mul_42csa csa42_l4_14(.i_x1(pdt3[4*k][  14]), .i_x2(pdt3[4*k+1][  13]), .i_x3(            1'b0), .i_x4(           1'b0), .i_e(l4_c[k][  13]), .o_s(pdt_lvl_4[k][0][  14]), .o_carry(pdt_lvl_4[k][1][  14]), .o_e(l4_c[k][  14]));
            gb_mul_42csa csa42_l4_15(.i_x1(pdt3[4*k][  15]), .i_x2(pdt3[4*k+1][  14]), .i_x3(            1'b0), .i_x4(           1'b0), .i_e(l4_c[k][  14]), .o_s(pdt_lvl_4[k][0][  15]), .o_carry(pdt_lvl_4[k][1][  15]), .o_e(l4_c[k][  15]));
            gb_mul_42csa csa42_l4_16(.i_x1(pdt3[4*k][  16]), .i_x2(pdt3[4*k+1][  15]), .i_x3(pdt3[4*k+2][  0]), .i_x4(           1'b0), .i_e(l4_c[k][  15]), .o_s(pdt_lvl_4[k][0][  16]), .o_carry(pdt_lvl_4[k][1][  16]), .o_e(l4_c[k][  16]));
        for (j = 0; j < 64; j = j + 1) begin
            gb_mul_42csa csa42_l4_  (.i_x1(pdt3[4*k][j+17]), .i_x2(pdt3[4*k+1][j+16]), .i_x3(pdt3[4*k+2][j+1]), .i_x4(pdt3[4*k+3][ j]), .i_e(l4_c[k][j+16]), .o_s(pdt_lvl_4[k][0][j+17]), .o_carry(pdt_lvl_4[k][1][j+17]), .o_e(l4_c[k][j+17]));
        end
            gb_mul_42csa csa42_l4_17(.i_x1(           1'b0), .i_x2(pdt3[4*k+1][  80]), .i_x3(pdt3[4*k+2][ 65]), .i_x4(pdt3[4*k+3][64]), .i_e(l4_c[k][  80]), .o_s(pdt_lvl_4[k][0][  81]), .o_carry(pdt_lvl_4[k][1][ 81]), .o_e(l4_c[k][ 81]));
            gb_mul_42csa csa42_l4_18(.i_x1(           1'b0), .i_x2(             1'b0), .i_x3(pdt3[4*k+2][ 66]), .i_x4(pdt3[4*k+3][65]), .i_e(l4_c[k][  81]), .o_s(pdt_lvl_4[k][0][  82]), .o_carry(pdt_lvl_4[k][1][ 82]), .o_e(l4_c[k][ 82]));
            gb_mul_42csa csa42_l4_19(.i_x1(           1'b0), .i_x2(             1'b0), .i_x3(pdt3[4*k+2][ 67]), .i_x4(pdt3[4*k+3][66]), .i_e(l4_c[k][  82]), .o_s(pdt_lvl_4[k][0][  83]), .o_carry(pdt_lvl_4[k][1][ 83]), .o_e(l4_c[k][ 83]));
            gb_mul_42csa csa42_l4_20(.i_x1(           1'b0), .i_x2(             1'b0), .i_x3(pdt3[4*k+2][ 68]), .i_x4(pdt3[4*k+3][67]), .i_e(l4_c[k][  83]), .o_s(pdt_lvl_4[k][0][  84]), .o_carry(pdt_lvl_4[k][1][ 84]), .o_e(l4_c[k][ 84]));
            gb_mul_42csa csa42_l4_21(.i_x1(           1'b0), .i_x2(             1'b0), .i_x3(pdt3[4*k+2][ 69]), .i_x4(pdt3[4*k+3][68]), .i_e(l4_c[k][  84]), .o_s(pdt_lvl_4[k][0][  85]), .o_carry(pdt_lvl_4[k][1][ 85]), .o_e(l4_c[k][ 85]));
            gb_mul_42csa csa42_l4_22(.i_x1(           1'b0), .i_x2(             1'b0), .i_x3(pdt3[4*k+2][ 70]), .i_x4(pdt3[4*k+3][69]), .i_e(l4_c[k][  85]), .o_s(pdt_lvl_4[k][0][  86]), .o_carry(pdt_lvl_4[k][1][ 86]), .o_e(l4_c[k][ 86]));
            gb_mul_42csa csa42_l4_23(.i_x1(           1'b0), .i_x2(             1'b0), .i_x3(pdt3[4*k+2][ 71]), .i_x4(pdt3[4*k+3][70]), .i_e(l4_c[k][  86]), .o_s(pdt_lvl_4[k][0][  87]), .o_carry(pdt_lvl_4[k][1][ 87]), .o_e(l4_c[k][ 87]));
            gb_mul_42csa csa42_l4_24(.i_x1(           1'b0), .i_x2(             1'b0), .i_x3(pdt3[4*k+2][ 72]), .i_x4(pdt3[4*k+3][71]), .i_e(l4_c[k][  87]), .o_s(pdt_lvl_4[k][0][  88]), .o_carry(pdt_lvl_4[k][1][ 88]), .o_e(l4_c[k][ 88]));
            gb_mul_42csa csa42_l4_25(.i_x1(           1'b0), .i_x2(             1'b0), .i_x3(pdt3[4*k+2][ 73]), .i_x4(pdt3[4*k+3][72]), .i_e(l4_c[k][  88]), .o_s(pdt_lvl_4[k][0][  89]), .o_carry(pdt_lvl_4[k][1][ 89]), .o_e(l4_c[k][ 89]));
            gb_mul_42csa csa42_l4_26(.i_x1(           1'b0), .i_x2(             1'b0), .i_x3(pdt3[4*k+2][ 74]), .i_x4(pdt3[4*k+3][73]), .i_e(l4_c[k][  89]), .o_s(pdt_lvl_4[k][0][  90]), .o_carry(pdt_lvl_4[k][1][ 90]), .o_e(l4_c[k][ 90]));
            gb_mul_42csa csa42_l4_27(.i_x1(           1'b0), .i_x2(             1'b0), .i_x3(pdt3[4*k+2][ 75]), .i_x4(pdt3[4*k+3][74]), .i_e(l4_c[k][  90]), .o_s(pdt_lvl_4[k][0][  91]), .o_carry(pdt_lvl_4[k][1][ 91]), .o_e(l4_c[k][ 91]));
            gb_mul_42csa csa42_l4_28(.i_x1(           1'b0), .i_x2(             1'b0), .i_x3(pdt3[4*k+2][ 76]), .i_x4(pdt3[4*k+3][75]), .i_e(l4_c[k][  91]), .o_s(pdt_lvl_4[k][0][  92]), .o_carry(pdt_lvl_4[k][1][ 92]), .o_e(l4_c[k][ 92]));
            gb_mul_42csa csa42_l4_29(.i_x1(           1'b0), .i_x2(             1'b0), .i_x3(pdt3[4*k+2][ 77]), .i_x4(pdt3[4*k+3][76]), .i_e(l4_c[k][  92]), .o_s(pdt_lvl_4[k][0][  93]), .o_carry(pdt_lvl_4[k][1][ 93]), .o_e(l4_c[k][ 93]));
            gb_mul_42csa csa42_l4_30(.i_x1(           1'b0), .i_x2(             1'b0), .i_x3(pdt3[4*k+2][ 78]), .i_x4(pdt3[4*k+3][77]), .i_e(l4_c[k][  93]), .o_s(pdt_lvl_4[k][0][  94]), .o_carry(pdt_lvl_4[k][1][ 94]), .o_e(l4_c[k][ 94]));
            gb_mul_42csa csa42_l4_31(.i_x1(           1'b0), .i_x2(             1'b0), .i_x3(pdt3[4*k+2][ 79]), .i_x4(pdt3[4*k+3][78]), .i_e(l4_c[k][  94]), .o_s(pdt_lvl_4[k][0][  95]), .o_carry(pdt_lvl_4[k][1][ 95]), .o_e(l4_c[k][ 95]));
            gb_mul_42csa csa42_l4_32(.i_x1(           1'b0), .i_x2(             1'b0), .i_x3(pdt3[4*k+2][ 80]), .i_x4(pdt3[4*k+3][79]), .i_e(l4_c[k][  95]), .o_s(pdt_lvl_4[k][0][  96]), .o_carry(pdt_lvl_4[k][1][ 96]), .o_e(l4_c[k][ 96]));
            gb_mul_42csa csa42_l4_33(.i_x1(           1'b0), .i_x2(             1'b0), .i_x3(            1'b0), .i_x4(pdt3[4*k+3][80]), .i_e(l4_c[k][  96]), .o_s(pdt_lvl_4[k][0][  97]), .o_carry(pdt_lvl_4[k][1][ 97]), .o_e(l4_c[k][ 97]));
        end
    endgenerate

    wire [97:0] pdt4 [3:0];
    wire [130:0] pdt_lvl_5 [1:0];

    generate
        for (i = 0; i < 2; i = i + 1) begin
            assign pdt4[i * 2 + 0] = pdt_lvl_4[i][0];
            assign pdt4[i * 2 + 1] = pdt_lvl_4[i][1];
        end
    endgenerate

    wire l5_c[130:0];

    generate
            gb_mul_42csa csa42_l5_00(.i_x1(pdt4[0][   0]), .i_x2(         1'b0), .i_x3(         1'b0), .i_x4(         1'b0), .i_e(      1'b0), .o_s(pdt_lvl_5[0][   0]), .o_carry(pdt_lvl_5[1][   0]), .o_e(l5_c[   0]));
        for (k = 0; k < 31; k = k + 1) begin
            gb_mul_42csa csa42_l5_  (.i_x1(pdt4[0][ k+1]), .i_x2(pdt4[1][   k]), .i_x3(         1'b0), .i_x4(         1'b0), .i_e(l5_c[   k]), .o_s(pdt_lvl_5[0][ k+1]), .o_carry(pdt_lvl_5[1][ k+1]), .o_e(l5_c[ k+1]));
        end
            gb_mul_42csa csa42_l5_01(.i_x1(pdt4[0][  32]), .i_x2(pdt4[1][  31]), .i_x3(pdt4[2][   0]), .i_x4(         1'b0), .i_e(l5_c[  31]), .o_s(pdt_lvl_5[0][  32]), .o_carry(pdt_lvl_5[1][  32]), .o_e(l5_c[  32]));
        for (j = 0; j < 65; j = j + 1) begin
            gb_mul_42csa csa42_l5_  (.i_x1(pdt4[0][j+33]), .i_x2(pdt4[1][j+32]), .i_x3(pdt4[2][ j+1]), .i_x4(pdt4[3][   j]), .i_e(l5_c[j+32]), .o_s(pdt_lvl_5[0][j+33]), .o_carry(pdt_lvl_5[1][j+33]), .o_e(l5_c[j+33]));
        end
            gb_mul_42csa csa42_l5_02(.i_x1(         1'b0), .i_x2(pdt4[1][  97]), .i_x3(pdt4[2][  66]), .i_x4(pdt4[3][  65]), .i_e(l5_c[  97]), .o_s(pdt_lvl_5[0][  98]), .o_carry(pdt_lvl_5[1][  98]), .o_e(l5_c[  98]));
        for (k = 0; k < 31; k = k + 1) begin
            gb_mul_42csa csa42_l5_  (.i_x1(         1'b0), .i_x2(         1'b0), .i_x3(pdt4[2][k+67]), .i_x4(pdt4[3][k+66]), .i_e(l5_c[k+98]), .o_s(pdt_lvl_5[0][k+99]), .o_carry(pdt_lvl_5[1][k+99]), .o_e(l5_c[k+99]));
        end
            gb_mul_42csa csa42_l5_03(.i_x1(         1'b0), .i_x2(         1'b0), .i_x3(         1'b0), .i_x4(pdt4[3][  97]), .i_e(l5_c[ 129]), .o_s(pdt_lvl_5[0][ 130]), .o_carry(pdt_lvl_5[1][ 130]), .o_e(l5_c[ 130]));
    endgenerate

    wire inc;
    gb_alu_cla64 cla64_0 (.i_a(pdt_lvl_5[0][ 63: 0]), .i_b({pdt_lvl_5[1][ 62: 0], 1'b0}), .i_c(1'b0), .o_pm(), .o_gm(), .o_s(o_res[ 63: 0]), .o_c(inc));
    gb_alu_cla64 cla64_1 (.i_a(pdt_lvl_5[0][127:64]), .i_b( pdt_lvl_5[1][126:63]       ), .i_c( inc), .o_pm(), .o_gm(), .o_s(o_res[127:64]), .o_c());
endmodule