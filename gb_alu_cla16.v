module gb_alu_cla16 (
    input wire [15:0] i_a,
    input wire [15:0] i_b,
    input wire i_c,

    output wire o_pm,
    output wire o_gm,

    output wire [15:0] o_s,
    output wire o_c

);
    wire [3:0] gm;
    wire [3:0] pm;
    wire [3:0] c;
    wire [3:0] oc;

    gb_alu_cla4 cla4_0  (.i_a(i_a[ 3: 0]), .i_b(i_b[ 3: 0]), .i_c( i_c), .o_s(o_s[ 3: 0]), .o_c(oc[0]), .o_pm(pm[0]), .o_gm(gm[0]));
    gb_alu_cla4 cla4_1  (.i_a(i_a[ 7: 4]), .i_b(i_b[ 7: 4]), .i_c(c[0]), .o_s(o_s[ 7: 4]), .o_c(oc[1]), .o_pm(pm[1]), .o_gm(gm[1]));
    gb_alu_cla4 cla4_2  (.i_a(i_a[11: 8]), .i_b(i_b[11: 8]), .i_c(c[1]), .o_s(o_s[11: 8]), .o_c(oc[2]), .o_pm(pm[2]), .o_gm(gm[2]));
    gb_alu_cla4 cla4_3  (.i_a(i_a[15:12]), .i_b(i_b[15:12]), .i_c(c[2]), .o_s(o_s[15:12]), .o_c(oc[3]), .o_pm(pm[3]), .o_gm(gm[3]));
    gb_alu_clu4 CLU     (.i_c(i_c), .i_g(gm), .i_p(pm), .o_c(c));
    gb_alu_pgm4 PGM     (.i_g(gm), .i_p(pm), .o_gm(o_gm), .o_pm(o_pm));

    assign o_c = c[3];

endmodule