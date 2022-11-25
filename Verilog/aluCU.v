module aluCU(op, ff, aluop); 
input [1:0] op; 
input [5:0] ff; 
output [2:0] aluop; 
wire a, b; 

assign a = op[1] & ff[1]; 
assign aluop[2] = op[0] | a; 
assign aluop[1] = (~op[1]) | (~ff[2]); 
assign b = ff[3] | ff[0]; 
assign aluop[0] = op[1] & b; 

endmodule 