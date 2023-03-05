module gb_alu_cla4 (
    input wire [3:0] i_a,
    input wire [3:0] i_b,
    input wire i_c,

    output wire o_pm,
    output wire o_gm,

    output wire [3:0] o_s,
    output wire o_c

);
    wire [3:0] g;
    wire [3:0] p;
    wire [3:0] c;
    // wire [3:0] t;

    gb_alu_pg   PG  (.i_a(i_a), .i_b(i_b), .o_g(g), .o_p(p));
    // gb_alu_tu   TU  (.i_g(g), .i_p(p), .o_t(t));
    gb_alu_clu4 CLU (.i_c(i_c), .i_g(g), .i_p(p), .o_c(c));
    gb_alu_pgm4 PGM (.i_g(g), .i_p(p), .o_gm(o_gm), .o_pm(o_pm));

    assign o_s = i_a ^ i_b ^ {c[2:0], i_c};

    assign o_c = c[3];

endmodule