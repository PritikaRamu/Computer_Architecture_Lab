module mux_4to1(out,in1, in2, in3, in4,sel);
input in1, in2, in3, in4;
input [1:0] sel;
output out;
wire a,b,c,d,n1,n2,a1,a2,a3,a4;
not n(n1,sel[0]);
not nn(n2,sel[1]);
and (a1,in1,n1,n2);
and (a2,in2,n2,sel[0]);
and (a3,in3,sel[1],n1);
and (a4,in4,sel[1],sel[0]);
or or1(out,a1,a2,a3,a4);
endmodule 