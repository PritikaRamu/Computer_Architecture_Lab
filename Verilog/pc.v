module pc(count, clk, rst);
 input clk, rst;
 output [31:0] count;
 always @(posedge clk)
    if(!rst)
        count = count +1;
    else
        count = 0;
endmodule