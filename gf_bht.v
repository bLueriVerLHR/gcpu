module gf_bht (
    input wire clk,

    input wire i_sig_cur_b_taken,
    input wire i_sig_cur_is_b,

    input wire i_sig_req,

    output wire o_sig_b_taken
);
    reg [1:0] BHT [4'b1111:4'b0000];
    reg [3:0] queue;

    wire [3:0] nxt_queue;
    assign nxt_queue = {queue[2:0], i_sig_cur_b_taken};

    // FSA
    //             ____          ____
    //            /    \  ____  /    \
    //  taken    11    10 ____ 01    00   non-taken
    //            \____/        \____/

    // predict part

    wire [3:0] pred_queue;
    assign pred_queue = i_sig_req & i_sig_cur_is_b ? nxt_queue : queue;

    wire [1:0] pred_status;
    assign pred_status = BHT[pred_queue];

    wire pred_stat_11, pred_stat_10, pred_stat_01, pred_stat_00;
    assign pred_stat_11 = pred_status == 2'b11;
    assign pred_stat_10 = pred_status == 2'b10;
    assign pred_stat_01 = pred_status == 2'b01;
    assign pred_stat_00 = pred_status == 2'b00;

    assign o_sig_b_taken = pred_stat_11 | pred_stat_10;

    // update part
    wire [1:0] cur_status;
    assign cur_status = BHT[queue];

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
            BHT[queue] <= i_sig_cur_b_taken ? nxt_pos_status
                                            : nxt_neg_status;
            queue <= nxt_queue;
        end
    end

endmodule