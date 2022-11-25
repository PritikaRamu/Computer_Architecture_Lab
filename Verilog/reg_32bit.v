`include "dff_sync_clear.v"         // d, clr, clk ,q
    module reg_32bit(
        output [31:0] q,
        input [31:0] d,
        input clk,
        input reset);

        genvar num;

        generate for (num = 0 ; num < 32 ; num = num + 1) begin: ffs
                d_ff dff(  q[num], d[num],clk, reset );
            end
        endgenerate
    endmodule