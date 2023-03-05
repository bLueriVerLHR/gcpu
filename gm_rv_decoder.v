`include "gd_alu.v"
`include "gd_lsu.v"
`include "gd_bru.v"
`include "gd_csr.v"

module gm_rv_decoder #(
    ADDR_LEN = 64,
    INST_LEN = 32,
    WORD_LEN = 64
) (
    input wire [INST_LEN-1:0] i_cur_inst,
    input wire [ADDR_LEN-1:0] i_cur_pc,
    
    // add sub sll srl sra xor or and
    output wire [2:0] o_alu_ctrl,
    output wire o_sig_alu,

    output wire o_sig_slt,

    // mul mulh div rem
    // 00  01   10  11
    output wire [1:0] o_mhdr,
    output wire o_sig_mhdr,

    // uu us su ss
    // 00 01 10 11
    output wire [1:0] o_op_signed,

    output wire o_sig_w32,

    // w  s  c
    // 00 01 10
    output wire [1:0] o_csrr,
    output wire [11:0] o_csr_addr,
    output wire o_sig_csrr,

    output wire o_sig_rs1_imm,
    output wire [WORD_LEN-1:0] o_rs1_imm,

    output wire o_sig_rs2_imm,
    output wire [WORD_LEN-1:0] o_rs2_imm,

    output wire [4:0] o_rs1_idx,
    output wire [4:0] o_rs2_idx,
    output wire [4:0] o_rd_idx,

    // eq ne lt ge
    // 00 11 01 10
    output wire [1:0] o_b_type,
    output wire o_sig_branch,

    // b  h  w  d
    // 00 01 10 11
    output wire [1:0] o_ls,
    output wire o_sig_ls,
    output wire o_sig_lhi_slo,

    output wire o_sig_agu,
    output wire o_sig_agu_use_pc,

    output wire o_sig_fence,
    output wire o_sig_fencei,

    output wire o_sig_ecall,
    output wire o_sig_ebreak
);
    // decode general info

    wire [6:0] funct7;
    wire [2:0] funct3;

    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [4:0] rd;

    wire [6:0] opcode;

    wire [1:0] opcode_1_0;
    wire [2:0] opcode_4_2;
    wire [1:0] optype_6_5;

    wire [4:0] funct5;
    wire [1:0] funct2;
    
    assign {funct7, rs2, rs1, funct3, rd, opcode} = i_cur_inst;
    assign {optype_6_5, opcode_4_2, opcode_1_0} = opcode;
    assign {funct5, funct2} = funct7;

    // signal gen

    wire opcode_1_0_00 = opcode_1_0 == 2'b00;
    wire opcode_1_0_01 = opcode_1_0 == 2'b01;
    wire opcode_1_0_10 = opcode_1_0 == 2'b10;
    wire opcode_1_0_11 = opcode_1_0 == 2'b11;

    wire opcode_4_2_000 = opcode_4_2 == 3'b000;
    wire opcode_4_2_001 = opcode_4_2 == 3'b001;
    wire opcode_4_2_010 = opcode_4_2 == 3'b010;
    wire opcode_4_2_011 = opcode_4_2 == 3'b011;
    wire opcode_4_2_100 = opcode_4_2 == 3'b100;
    wire opcode_4_2_101 = opcode_4_2 == 3'b101;
    wire opcode_4_2_110 = opcode_4_2 == 3'b110;
    wire opcode_4_2_111 = opcode_4_2 == 3'b111;

    wire optype_6_5_00 = optype_6_5 == 2'b00;
    wire optype_6_5_01 = optype_6_5 == 2'b01;
    wire optype_6_5_10 = optype_6_5 == 2'b10;
    wire optype_6_5_11 = optype_6_5 == 2'b11;

    wire funct3_000 = funct3 == 3'b000;
    wire funct3_001 = funct3 == 3'b001;
    wire funct3_010 = funct3 == 3'b010;
    wire funct3_011 = funct3 == 3'b011;
    wire funct3_100 = funct3 == 3'b100;
    wire funct3_101 = funct3 == 3'b101;
    wire funct3_110 = funct3 == 3'b110;
    wire funct3_111 = funct3 == 3'b111;

    wire funct2_00 = funct2 == 2'b00;
    wire funct2_01 = funct2 == 2'b01;
    wire funct2_10 = funct2 == 2'b10;
    wire funct2_11 = funct2 == 2'b11;

    wire funct5_00000 = funct5 == 5'b00000;
    wire funct5_00001 = funct5 == 5'b00001;
    wire funct5_00010 = funct5 == 5'b00010;
    wire funct5_00011 = funct5 == 5'b00011;
    wire funct5_00100 = funct5 == 5'b00100;
    wire funct5_00101 = funct5 == 5'b00101;
    wire funct5_00110 = funct5 == 5'b00110;
    wire funct5_00111 = funct5 == 5'b00111;
    wire funct5_01000 = funct5 == 5'b01000;
    wire funct5_01001 = funct5 == 5'b01001;
    wire funct5_01010 = funct5 == 5'b01010;
    wire funct5_01011 = funct5 == 5'b01011;
    wire funct5_01100 = funct5 == 5'b01100;
    wire funct5_01101 = funct5 == 5'b01101;
    wire funct5_01110 = funct5 == 5'b01110;
    wire funct5_01111 = funct5 == 5'b01111;
    wire funct5_10000 = funct5 == 5'b10000;
    wire funct5_10001 = funct5 == 5'b10001;
    wire funct5_10010 = funct5 == 5'b10010;
    wire funct5_10011 = funct5 == 5'b10011;
    wire funct5_10100 = funct5 == 5'b10100;
    wire funct5_10101 = funct5 == 5'b10101;
    wire funct5_10110 = funct5 == 5'b10110;
    wire funct5_10111 = funct5 == 5'b10111;
    wire funct5_11000 = funct5 == 5'b11000;
    wire funct5_11001 = funct5 == 5'b11001;
    wire funct5_11010 = funct5 == 5'b11010;
    wire funct5_11011 = funct5 == 5'b11011;
    wire funct5_11100 = funct5 == 5'b11100;
    wire funct5_11101 = funct5 == 5'b11101;
    wire funct5_11110 = funct5 == 5'b11110;
    wire funct5_11111 = funct5 == 5'b11111;
    

    wire op_load        = optype_6_5_00 & opcode_4_2_000;
    wire op_load_fp     = optype_6_5_00 & opcode_4_2_001;
    wire op_custom_0    = optype_6_5_00 & opcode_4_2_010;
    wire op_misc_mem    = optype_6_5_00 & opcode_4_2_011;
    wire op_op_imm      = optype_6_5_00 & opcode_4_2_100;
    wire op_auipc       = optype_6_5_00 & opcode_4_2_101;
    wire op_op_imm_32   = optype_6_5_00 & opcode_4_2_110;
    // wire = optype_6_5_00 & opcode_4_2_111;
    wire op_store       = optype_6_5_01 & opcode_4_2_000;
    wire op_store_fp    = optype_6_5_01 & opcode_4_2_001;
    wire op_custom_1    = optype_6_5_01 & opcode_4_2_010;
    wire op_amo         = optype_6_5_01 & opcode_4_2_011;
    wire op_op          = optype_6_5_01 & opcode_4_2_100;
    wire op_lui         = optype_6_5_01 & opcode_4_2_101;
    wire op_op_32       = optype_6_5_01 & opcode_4_2_110;
    // wire = optype_6_5_01 & opcode_4_2_111;
    wire op_madd        = optype_6_5_10 & opcode_4_2_000;
    wire op_msub        = optype_6_5_10 & opcode_4_2_001;
    wire op_nmsub       = optype_6_5_10 & opcode_4_2_010;
    wire op_nmadd       = optype_6_5_10 & opcode_4_2_011;
    wire op_op_fp       = optype_6_5_10 & opcode_4_2_100;
    // wire = optype_6_5_10 & opcode_4_2_101;
    wire op_custom_2_rv128 = optype_6_5_10 & opcode_4_2_110;
    // wire = optype_6_5_10 & opcode_4_2_111;
    wire op_branch      = optype_6_5_11 & opcode_4_2_000;
    wire op_jalr        = optype_6_5_11 & opcode_4_2_001;
    // wire = optype_6_5_11 & opcode_4_2_010;
    wire op_jal         = optype_6_5_11 & opcode_4_2_011;
    wire op_system      = optype_6_5_11 & opcode_4_2_100;
    // wire = optype_6_5_11 & opcode_4_2_101;
    wire op_custom_3_rv128 = optype_6_5_11 & opcode_4_2_110;
    // wire = optype_6_5_11 & opcode_4_2_111;

    wire type_r = op_op & op_op_32;
    wire type_i = op_op_imm & op_op_imm_32 & op_load;
    wire type_s = op_store;
    wire type_b = op_branch;
    wire type_u = op_auipc & op_lui;
    wire type_j = op_jalr;
    wire Ntype  = op_system;

    wire rs1_r0 = rs1 == 5'b00000;
    wire rs2_r0 = rs2 == 5'b00000;
    wire rd_r0  = rd  == 5'b00000;

    wire alu_add = (op_op_imm | op_op_imm_32) & funct3_000                            | (op_op | op_op_32) & funct3_000 & funct5_00000 & funct2_00;
    wire alu_sub =                                                                      (op_op | op_op_32) & funct3_000 & funct5_01000 & funct2_00;
    wire alu_sll = (op_op_imm | op_op_imm_32) & funct3_001                            | (op_op | op_op_32) & funct3_001 & funct5_00000 & funct2_00;
    wire alu_slt = (op_op_imm | op_op_imm_32) & funct3_010                            | (op_op | op_op_32) & funct3_010 & funct5_00000 & funct2_00;
    wire alu_sltu= (op_op_imm | op_op_imm_32) & funct3_011                            | (op_op | op_op_32) & funct3_011 & funct5_00000 & funct2_00;
    wire alu_xor = (op_op_imm | op_op_imm_32) & funct3_100                            | (op_op | op_op_32) & funct3_100 & funct5_00000 & funct2_00;
    wire alu_srl = (op_op_imm | op_op_imm_32) & funct3_101                            | (op_op | op_op_32) & funct3_101 & funct5_00000 & funct2_00;
    wire alu_sra = (op_op_imm | op_op_imm_32) & funct3_101 & funct5_01000 & funct2_00 | (op_op | op_op_32) & funct3_101 & funct5_01000 & funct2_00;
    wire alu_or  = (op_op_imm | op_op_imm_32) & funct3_110                            | (op_op | op_op_32) & funct3_110 & funct5_00000 & funct2_00;
    wire alu_and = (op_op_imm | op_op_imm_32) & funct3_111                            | (op_op | op_op_32) & funct3_111 & funct5_00000 & funct2_00;

    wire mhdr_mul     = (op_op | op_op_32) & funct3_000 & funct5_00000 & funct2_01;
    wire mhdr_mulh    = (op_op | op_op_32) & funct3_001 & funct5_00000 & funct2_01;
    wire mhdr_mulhsu  = (op_op | op_op_32) & funct3_010 & funct5_00000 & funct2_01;
    wire mhdr_mulhu   = (op_op | op_op_32) & funct3_011 & funct5_00000 & funct2_01;
    wire mhdr_div     = (op_op | op_op_32) & funct3_100 & funct5_00000 & funct2_01;
    wire mhdr_divu    = (op_op | op_op_32) & funct3_101 & funct5_00000 & funct2_01;
    wire mhdr_rem     = (op_op | op_op_32) & funct3_110 & funct5_00000 & funct2_01;
    wire mhdr_remu    = (op_op | op_op_32) & funct3_111 & funct5_00000 & funct2_01;

    wire branch_eq  = op_branch & funct3_000;
    wire branch_ne  = op_branch & funct3_001;
    wire branch_lt  = op_branch & funct3_100;
    wire branch_ge  = op_branch & funct3_101;
    wire branch_ltu = op_branch & funct3_110;
    wire branch_geu = op_branch & funct3_111;

    wire load_byte  = op_load & funct3_000;
    wire load_half  = op_load & funct3_001;
    wire load_word  = op_load & funct3_010;
    wire load_dword = op_load & funct3_011;

    wire load_ubyte = op_load & funct3_100;
    wire load_uhalf = op_load & funct3_101;
    wire load_uword = op_load & funct3_110;

    wire store_byte  = op_store & funct3_000;
    wire store_half  = op_store & funct3_001;
    wire store_word  = op_store & funct3_010;
    wire store_dword = op_store & funct3_011;
    
    wire e_fence  = op_misc_mem & funct3_000 & rd_r0 & rs1_r0;
    wire e_fencei = op_misc_mem & funct3_001 & rd_r0 & rs1_r0;

    wire e_ecall  = op_system & funct3_000 & funct5_00000 & funct2_00 & rd_r0 & rs1_r0 & rs2_r0;
    wire e_ebreak = op_system & funct3_000 & funct5_00000 & funct2_00 & rd_r0 & rs1_r0 & (rs2 == 5'b00001);

    wire csrr_w  = op_system & funct3_001;
    wire csrr_s  = op_system & funct3_010;
    wire csrr_c  = op_system & funct3_011;
    wire csrr_wi = op_system & funct3_101;
    wire csrr_si = op_system & funct3_110;
    wire csrr_ci = op_system & funct3_111;

    // imm gen

    wire [WORD_LEN-1:0] immI = {{(WORD_LEN-12){i_cur_inst[31]}}, i_cur_inst[31:20]};
    wire [WORD_LEN-1:0] immS = {{(WORD_LEN-12){i_cur_inst[31]}}, i_cur_inst[31:25], i_cur_inst[11: 7]};
    wire [WORD_LEN-1:0] immB = {{(WORD_LEN-13){i_cur_inst[31]}}, i_cur_inst[31], i_cur_inst[7], i_cur_inst[30:25], i_cur_inst[11: 8], 1'b0};
    wire [WORD_LEN-1:0] immU = {{(WORD_LEN-32){i_cur_inst[31]}}, i_cur_inst[31:12], {12{1'b0}}};
    wire [WORD_LEN-1:0] immJ = {{(WORD_LEN-21){i_cur_inst[31]}}, i_cur_inst[31], i_cur_inst[19:12], i_cur_inst[20], i_cur_inst[30:21], 1'b0};

    // sel imm
    wire [WORD_LEN-1:0] imm = {WORD_LEN{type_i}} & immI |
                              {WORD_LEN{type_s}} & immS |
                              {WORD_LEN{type_b}} & immB |
                              {WORD_LEN{type_u}} & immU |
                              {WORD_LEN{type_j}} & immJ ;

    assign o_sig_alu = op_op | op_op_32 | op_op_imm | op_op_imm_32
                        | op_branch | op_jal | op_jalr | op_auipc | op_lui;

    assign o_alu_ctrl =  {3{alu_add}} & `ALU_CTRL_ADD |
                         {3{alu_sub}} & `ALU_CTRL_SUB |
                         {3{alu_sll}} & `ALU_CTRL_SLL |
                         {3{alu_srl}} & `ALU_CTRL_SRL |
                         {3{alu_sra}} & `ALU_CTRL_SRA |
                         {3{alu_xor}} & `ALU_CTRL_XOR |
                         {3{alu_or }} & `ALU_CTRL_OR  |
                         {3{alu_and}} & `ALU_CTRL_AND |
                         {3{alu_slt | alu_sltu}} & `ALU_CTRL_SUB |
                         {3{branch_eq | branch_ne }} & `ALU_CTRL_XOR |
                         {3{branch_ge | branch_geu}} & `ALU_CTRL_SUB |
                         {3{branch_lt | branch_ltu}} & `ALU_CTRL_SUB |
                         {3{op_jal | op_jalr | op_auipc | op_lui}} & `ALU_CTRL_ADD ;
    
    assign o_sig_slt = alu_slt | alu_sltu;

    assign o_mhdr = {2{mhdr_mul}} & `LPIP_OP_MUL  |
                    {2{mhdr_mulh | mhdr_mulhsu | mhdr_mulhu}} & `LPIP_OP_MULH |
                    {2{mhdr_div  | mhdr_divu}} & `LPIP_OP_DIV  |
                    {2{mhdr_rem  | mhdr_remu}} & `LPIP_OP_REM  ;
    
    assign o_sig_mhdr = (op_op | op_op_32) & funct5_00000 & funct2_01;

    assign o_op_signed = mhdr_mulhsu ? `ALU_OP_SU :
                         (mhdr_mulhu | mhdr_divu | mhdr_remu
                            | alu_sltu
                            | branch_geu | branch_ltu
                            | load_ubyte | load_uhalf | load_uword)  ? `ALU_OP_UU :
                         `ALU_OP_SS;

    assign o_sig_w32 = op_op_32 | op_op_imm_32;

    assign o_csrr = {2{csrr_w | csrr_wi}} & `CSR_W |
                    {2{csrr_s | csrr_si}} & `CSR_S |
                    {2{csrr_c | csrr_ci}} & `CSR_C ;
    
    assign o_csr_addr = {funct7, rs2};

    assign o_sig_csrr = csrr_w | csrr_s | csrr_c | csrr_wi | csrr_si | csrr_ci;

    assign o_rs1_idx = rs1;
    assign o_rs2_idx = rs2;
    assign o_rd_idx  = rd ;

    assign o_b_type = {2{branch_eq}} & `OP_B_EQ |
                      {2{branch_ne}} & `OP_B_NE |
                      {2{branch_lt | branch_ltu}} & `OP_B_LT |
                      {2{branch_ge | branch_geu}} & `OP_B_GE ;

    assign o_sig_branch = op_branch;

    assign o_ls = {2{load_byte | load_ubyte | store_byte}} & `LS_B |
                  {2{load_half | load_uhalf | store_half}} & `LS_H |
                  {2{load_word | load_uword | store_word}} & `LS_W |
                  {2{load_dword | store_dword}} & `LS_D ;

    assign o_sig_ls = op_store | op_load;

    assign o_sig_lhi_slo = op_load & ~op_store;

    assign o_sig_agu = op_load | op_store | op_jal | op_jalr | op_branch;

    assign o_sig_agu_use_pc = op_jal | op_jalr | op_branch;

    assign o_sig_fence  = e_fence;
    assign o_sig_fencei = e_fencei;

    assign o_sig_ecall = e_ecall;
    
    assign o_sig_ebreak = e_ebreak;

endmodule