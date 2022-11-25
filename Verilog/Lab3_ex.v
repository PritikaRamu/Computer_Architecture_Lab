module fsm(clk, rst, in, out);

    input clk, rst, in;
    output out;
    reg [0:2] state;
    reg out;
    
    always @(posedge clk, posedge rst)
    begin
        if(rst)
            begin
                state <= 3'd0;
                out <= 1'b0;
            end

        else 
            begin 
                case(state) 
                    3'd0: 
                    begin 
                        if(in) 
                            begin
                                state <= 3'd1;
                                out <= 1'b0;  
                            end  
                        else
                            begin
                                state <= 3'd0;
                                out <= 1'b0;
                            end
                    end 
                    3'd1:
                    begin
                        if(in)
                            begin
                                state <= 3'd1;
                                out <= 1'b0;
                            end 
                        else
                            begin
                                state <= 3'd2;
                                out <= 1'b0;
                            end
                    end
                    3'd2:
                    begin
                        if(in)
                            begin
                                state <= 3'd3;
                                out <= 1'b0;
                            end 
                        else
                            begin
                                state <= 3'd0;
                                out <= 1'b0;
                            end
                    end
                    3'd3:
                    begin
                        if(in)
                            begin
                                state <= 3'd4;
                                out <= 1'b0;
                            end 
                        else
                            begin
                                state <= 3'd0;
                                out <= 1'b0;
                            end
                    end
                    3'd4:
                    begin
                        if(in)
                            begin
                                state <= 3'd1;
                                out <= 1'b0;
                            end 
                        else
                            begin
                                state <= 3'd2;
                                out <= 1'b1;
                            end
                    end
                endcase
            end
    end
endmodule

module testbench;

reg  clk, rst, inp; 
wire outp; 
reg[0:15] sequence; 
integer i; 
 
fsm a( clk, rst, inp, outp); 
 
initial 
begin 
clk = 0; 
rst = 1; 
sequence = 16'b1011011011111111; 
#5 rst = 0; 
 
for( i = 0; i <= 15; i = i + 1) 
begin 
inp = sequence[i]; 
#2 clk = 1; 
#2 clk = 0; 
$display("State = ", a.state, " Input = ", inp, ", Output = ", outp); 
end 
end

endmodule