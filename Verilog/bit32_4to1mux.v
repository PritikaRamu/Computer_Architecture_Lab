`include "mux_4to1.v"
module bit32_4to1mux(out, sel, in1, in2, in3, in4); 
input [31:0] in1,in2, in3, in4;
output [31:0] out;
input [1:0] sel;
genvar j;
//this is the variable that is be used in the generate
//block
generate for (j=0; j<4;j=j+1) begin: mux_loop
//mux_loop is the name of the loop
bit8_4to1mux m1(out[(j * 8 + 7):(j * 8)],sel,in1[(j * 8 + 7):(j * 8)],in2[(j * 8 + 7):(j * 8)], in3[(j * 8 + 7):(j * 8)], in4[(j * 8 + 7):(j * 8)]);
//mux2to1 is instantiated every time it is called
end
endgenerate
endmodule 

module bit8_4to1mux(out,sel,in1,in2, in3, in4);
input [7:0] in1,in2, in3, in4;
output [7:0] out;
input [1:0] sel;
genvar j;
//this is the variable that is to be used in the generate
//block
generate for (j=0; j<8;j=j+1) begin: mux_loop
//mux_loop is the name of the loop
mux_4to1 m1(out[j],in1[j],in2[j], in3[j], in4[j],sel);
//mux2to1 is instantiated every time it is called
end
endgenerate
endmodule 