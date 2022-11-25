module jk_ff(q,j,k,clk,rst);
    output q; 
    input j,k,clk,rst;
    reg q;

    always @(posedge clk) begin
            if(rst)
                q <= 1'b0;
            else begin
                case({j,k})
                    2'b0_0:     q <= q;
                    2'b0_1:     q <= 0;
                    2'b1_0:     q <= 1;
                    2'b1_1:     q <= ~q;
                endcase
            end
        end
endmodule

module counter(out, clk, rst);
    input clk,rst;
    output [3:0] out;

    wire and1;
    assign and1 = out[1] & out[0];
    wire and2;
    assign and2 = out[2] & and1;

    jk_ff a(out[0],1'b1,1'b1,clk,rst);
    jk_ff b(out[1],out[0],out[0],clk,rst);
    jk_ff c(out[2],and1,and1,clk,rst);
    jk_ff d(out[3],and2,and2,clk,rst);
endmodule

module testbench;
    reg clk,rst;
    wire [3:0] out;

    initial
        clk = 0;
    
    always 
    # 2clk = ~clk;

    initial begin
        $monitor ("q = %b ", out, " clk = %b ", clk, " rst = %b", rst);
    end

    counter a(out,clk,rst);

    initial begin
        rst = 1'b1;
        #4 rst = 1'b0;
        #80 $finish;
    end
endmodule