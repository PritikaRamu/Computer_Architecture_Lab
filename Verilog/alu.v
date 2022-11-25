`include "32_bit_adder.v"       //(sum,cout,num1, num2,cin );
    `include "bit32AND.v"        //module_32bitAND( outp, in1, in2 );
    `include "bit32OR.v"         //module_32bitOR( outp, in1, in2 );
    `include "mux_2to1_32bit.v"     //mux_2to1_32bit( outp, inp1, inp2, sel );
    `include "bit32_4to1mux.v"     //mux_3to1_32bit( outp, inp1, inp2, inp3, sel );

module alu(a, b, binv, cin, op, result, cout, zero); 
input [31:0] a, b; 
input binv, cin; 
input [1:0] op; 
output [31:0] result; 
output cout, zero; 
wire [31:0] c, d, e, f; 

assign cout = 1'b0; 
mux_2to1_32bit mux2(b,~b,binv,c); 
bit32AND a1 (d,a,c); 
bit32OR o1 (e,a,c); 
bit32_adder adder(f, cout, a, c, cin ); 
bit32_4to1mux mux4 (result,op,d,e,f,0); 
assign zero = (result == 32'b0) ? 1'b0 : 1'b1;

endmodule 