module gf_pht #(
    ADDR_LEN = 64
) (
    input wire clk,

    input wire [ADDR_LEN-1:0] i_req_inst_addr,
    input wire i_sig_req,

    input wire [ADDR_LEN-1:0] i_cur_inst_addr,
    input wire i_sig_cur_b_taken,
    input wire i_sig_cur_is_b,

    output wire o_sig_b_taken
);
    reg [1:0] PHT [10'b1111111111:10'b0000000000];

    wire [9:0] req_addr_hash;
    assign req_addr_hash = i_req_inst_addr[11:2];
    
    wire [9:0] cur_addr_hash;
    assign cur_addr_hash = i_cur_inst_addr[11:2];

    // FSA
    //             ____          ____
    //            /    \  ____  /    \
    //  taken    11    10 ____ 01    00   non-taken
    //            \____/        \____/

    // predict part
    wire req_eq_cur;
    assign req_eq_cur = req_addr_hash == cur_addr_hash;

    wire [1:0] pred_status;
    assign pred_status = PHT[req_addr_hash];

    wire pred_stat_11, pred_stat_10, pred_stat_01, pred_stat_00;
    assign pred_stat_11 = pred_status == 2'b11;
    assign pred_stat_10 = pred_status == 2'b10;
    assign pred_stat_01 = pred_status == 2'b01;
    assign pred_stat_00 = pred_status == 2'b00;

    assign o_sig_b_taken = pred_stat_11 | pred_stat_10
                            | (pred_stat_01 & req_eq_cur & i_sig_cur_b_taken);

    // update part
    wire [1:0] cur_status;
    assign cur_status = PHT[cur_addr_hash];

    wire cur_stat_11, cur_stat_10, cur_stat_01, cur_stat_00;
    assign cur_stat_11 = cur_status == 2'b11;
    assign cur_stat_10 = cur_status == 2'b10;
    assign cur_stat_01 = cur_status == 2'b01;
    assign cur_stat_00 = cur_status == 2'b00;

    wire [1:0] nxt_pos_status;
    assign nxt_pos_status = cur_stat_11 | cur_stat_10 ? 2'b11 :
                                          cur_stat_01 ? 2'b10 : 2'b01 ;

    wire [1:0] nxt_neg_status;
    assign nxt_neg_status = cur_stat_01 | cur_stat_00 ? 2'b00 :
                                          cur_stat_10 ? 2'b01 : 2'b10 ;

    always @(posedge clk) begin
        if (i_sig_cur_is_b) begin
            PHT[cur_addr_hash] <= i_sig_cur_b_taken ? nxt_pos_status
                                                    : nxt_neg_status;
        end
    end

endmodule