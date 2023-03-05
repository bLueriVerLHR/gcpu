module gf_pc_gen #(
    ADDR_LEN  = 64,
    INST_BLEN = 4,
    RST_ADDR  = 64'b0
) (
    input wire clk,
    input wire i_sig_rst,

    input wire [ADDR_LEN-1:0] i_vec_tbl,
    input wire [ADDR_LEN-1:0] i_e_id,
    input wire i_sig_e,

    input wire [ADDR_LEN-1:0] i_jmp_target,
    input wire i_sig_recv_jmp,

    input wire [ADDR_LEN-1:0] i_last_pc,

    output reg [ADDR_LEN-1:0] o_pc
);
    wire [ADDR_LEN-1:0] e_addr;
    assign e_addr = i_sig_e ? i_vec_tbl + i_e_id : 0;

    wire [ADDR_LEN-1:0] jmp_addr;
    assign jmp_addr = i_sig_recv_jmp ? i_jmp_target : 0;

    wire alt, err;
    assign alt = i_sig_e | i_sig_recv_jmp;
    assign err = i_sig_e & i_sig_recv_jmp;

    wire [ADDR_LEN-1:0] alt_addr;
    assign alt_addr = e_addr | jmp_addr;

    always @(posedge clk) begin
        if (i_sig_rst | err) o_pc <= RST_ADDR;
        else if (alt) o_pc <= alt_addr;
        else o_pc <= i_last_pc + INST_BLEN;
    end

endmodule