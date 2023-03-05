module gb_mul_42csa (
    input wire i_x1,
    input wire i_x2,
    input wire i_x3,
    input wire i_x4,
    input wire i_e,

    output wire o_s,
    output wire o_carry,
    output wire o_e
);
    
    assign o_e = (i_x4 & i_x3 & i_x2 & i_x1)
               | (i_e  & i_x3 & i_x2 & i_x1)
               | (i_x4 & i_e  & i_x2 & i_x1)
               | (i_x4 & i_x3 & i_e  & i_x1)
               | (i_x4 & i_x3 & i_x2 & i_e);

    assign o_s = i_x4 ^ i_x3 ^ i_x2 ^ i_x1 ^ i_e;
    
    assign o_carry = (i_x1 & i_x2) | (i_x1 & i_x3) | (i_x1 & i_x4)
                   | (i_x2 & i_x3) | (i_x2 & i_x4) | (i_x3 & i_x4)
                   | (i_e  & i_x1) | (i_e  & i_x2) | (i_e  & i_x3) | (i_e  & i_x4);
endmodule