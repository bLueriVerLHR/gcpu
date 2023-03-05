`include "gd_alu.v"

module gb_alu (
    input wire [2:0] i_alu_ctrl,
    input wire i_sig_alu,
    input wire [1:0] i_op_signed,
    input wire i_sig_w32,
    input wire [1:0] o_op_signed,
    
    input wire [63:0] i_op1,
    input wire [63:0] i_op2,

    output wire zflag,  // zero flag
    output wire oflag,  // overflow flag
    output wire ltflag, // less than flag 

    output wire [63:0] o_res
);
    wire [63:0] add_res;
    wire [63:0]  or_res;
    wire [63:0] xor_res;
    wire [63:0] and_res;

    wire [63:0] srl_res;
    wire [63:0] sra_res;
    wire [63:0] sll_res;

    wire [63:0] addop2 = i_alu_ctrl == `ALU_CTRL_SUB ? ~i_op2 + 1 : i_op2;
    wire add_c;
    gb_alu_cla64 cla64 (.i_a(i_op1), .i_b(addop2), .i_c(0), .o_pm(), .o_gm(), .o_s(add_res), .o_c(add_c));
    
    wire second_sign;
    gb_alu_fa fa (.i_a(i_op1[63]), .i_b(addop2[63]), .i_c(add_c), .o_s(second_sign), .o_c());

    gb_alu_sll sll (.i_base(i_op1), .i_shamt(i_op2[6:0]), .o_sll(sll_res));
    gb_alu_srl srl (.i_base(i_op1), .i_shamt(i_op2[6:0]), .o_srl(srl_res));
    gb_alu_sra sra (.i_base(i_op1), .i_shamt(i_op2[6:0]), .o_sra(sra_res));

    assign xor_res = i_op1 ^ i_op2;
    assign  or_res = i_op1 | i_op2;
    assign and_res = i_op1 & i_op2;

    assign o_res =  {64{i_alu_ctrl == `ALU_CTRL_ADD}} & add_res |
                    {64{i_alu_ctrl == `ALU_CTRL_SLL}} & sll_res |
                    {64{i_alu_ctrl == `ALU_CTRL_SRL}} & srl_res |
                    {64{i_alu_ctrl == `ALU_CTRL_SRA}} & sra_res |
                    {64{i_alu_ctrl == `ALU_CTRL_XOR}} & xor_res |
                    {64{i_alu_ctrl == `ALU_CTRL_OR }} &  or_res |
                    {64{i_alu_ctrl == `ALU_CTRL_AND}} & and_res ;

    assign zflag = o_res == 64'b0;

    assign oflag = (i_alu_ctrl == `ALU_CTRL_SUB | i_alu_ctrl == `ALU_CTRL_ADD) &
                    ((i_op1[63] & addop2[63] & ~add_res[63]) | (~i_op1[63] & ~addop2[63] & add_res[63]));
    
    wire signed_cmp = second_sign;
    wire unsigned_cmp = i_op1 < i_op2;
    assign ltflag = (i_alu_ctrl != `ALU_CTRL_SUB) ? 0 :
                    (o_op_signed == `ALU_OP_UU  ) ? unsigned_cmp : signed_cmp;

endmodule