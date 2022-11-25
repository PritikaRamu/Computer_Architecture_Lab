module mux_2to1_32bit (a,b,s,f);
input [31:0] a,b; 
input s; 
output [31:0] f;
assign f = s ? b : a;
endmodule 