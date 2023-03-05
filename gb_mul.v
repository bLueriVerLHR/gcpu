`include "gd_alu.v"

module gb_mul (
    input wire [63:0] i_op1,
    input wire [63:0] i_op2,

    input wire [1:0] i_mhdr,
    input wire [1:0] i_op_signed,

    output wire [63:0] o_res
);
    // wire op_mul = (i_mhdr == `LPIP_OP_MUL) | (i_mhdr == `LPIP_OP_MULH);
    wire need_h = i_mhdr == `LPIP_OP_MULH;
    
    wire [63:0] mul_op1;
    wire [63:0] mul_op2;

    assign mul_op1 = i_op_signed[1] & i_op1[63] ? ~i_op1 + 1 : i_op1;
    assign mul_op2 = i_op_signed[0] & i_op2[63] ? ~i_op2 + 1 : i_op2;

    wire neg = (i_op_signed[1] & i_op1[63]) ^ (i_op_signed[0] & i_op2[63]);

    wire [127:0] tmp_res;

    gb_mul_wt64 wt64 (.i_a(mul_op1), .i_b(mul_op2), .o_res(tmp_res));

    wire [127:0] signed_res = neg ? ~tmp_res + 1 : tmp_res;

    assign o_res = need_h ? signed_res[127:64] : signed_res[63:0];

endmodule