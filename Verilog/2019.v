//`timescale 1ms/1ns

module mux2to1(out,sel,in); 
  input [1:0] in;
  input sel; 
  output out; 
  assign out = (~sel & in[0]) | (sel & in[1]); 
endmodule 

module mux8to1(out,sel,in); 
  input [7:0] in;
  input [2:0] sel; 
  output out; 
  assign out = (~sel[0] & ~sel[1] & ~sel[2] & in[0]) | (sel[0] & ~sel[1] & ~sel[2] & in[1]) | (~sel[0] & sel[1] & ~sel[2] & in[2]) | (sel[0] & sel[1] & ~sel[2] & in[3]) | (~sel[0] & ~sel[1] & sel[2] & in[4]) | (sel[0] & ~sel[1] & sel[2] & in[5]) | (~sel[0] & sel[1] & sel[2] & in[6]) | (sel[0] & sel[1] & sel[2] & in[7]); 
endmodule 

module mux_array(in,out,sel);
    input [7:0] in, sel;
    output [7:0] out;
    genvar j;

    generate
        for(j=0; j<8; j=j+1) begin
            mux2to1 m(out[j],sel[j],{in[j],1'b0});
        end
    endgenerate
endmodule

module counter(clk,clr,q);
    input clk, clr;
    output [2:0] q;
    reg q;

    always @(clr) begin
        if(clr)
            q = 3'b0;
    end

    always @(posedge clk) begin
        case(q)
            3'b000: q = 3'b001;
            3'b001: q = 3'b010;
            3'b010: q = 3'b011;
            3'b011: q = 3'b100;
            3'b100: q = 3'b101;
            3'b101: q = 3'b110;
            3'b110: q = 3'b111;
            3'b111: q = 3'b000;
        endcase
    end
endmodule

module decoder(a,en,b);
    input [2:0] a;
    input en;
    output reg [7:0] b;

    always @(en) begin
        if(en) begin
            case(a)
            3'b000: b = 8'b00000001;
            3'b001: b = 8'b00000010;
            3'b010: b = 8'b00000100;
            3'b011: b = 8'b00001000;
            3'b100: b = 8'b00010000;
            3'b101: b = 8'b00100000;
            3'b110: b = 8'b01000000;
            3'b111: b = 8'b10000000;
            endcase
        end
    end
endmodule

module ram(s,g);
    input [2:0] s;
    output reg [7:0] g;

    reg [7:0] mem [0:7];

    initial begin
        mem[0]=8'h01;
        mem[1]=8'h03;
        mem[2]=8'h07;
        mem[3]=8'h0F;
        mem[4]=8'h1F;
        mem[5]=8'h3F;
        mem[6]=8'h7F;
        mem[7]=8'hFF;
    end

    always @(s) begin
        case(s)
        3'b000: g = mem[0];
        3'b001: g = mem[1];
        3'b010: g = mem[2];
        3'b011: g = mem[3];
        3'b100: g = mem[4];
        3'b101: g = mem[5];
        3'b110: g = mem[6];
        3'b111: g = mem[7];
        endcase
    end
endmodule

module top_module(clk, clr, en, s,o);
    input clk, clr, en;
    input [2:0] s;

    wire [2:0] q;
    wire [7:0] b;
    wire [7:0] e,g;
    output o;

    counter c(clk,clr,q);
    decoder d(q,en,b);
    mux_array a(b,e,g);
    ram r(s,g);
    mux8to1 m(o,q,e);

endmodule


module tb;
    reg clk, clr, en;
    reg [2:0] s;
    wire out;
    integer j;

    top_module tm(clk, clr, en, s, out);

    always	
		#1 clk = ~clk;
	
	initial begin
			s = 3'b0;
			clr = 1'b1;
		#100 $finish;
	end
	
	always
		#8	s = s+1;

    initial
		$monitor($time,"  , CLK = %b, S = %b, CLEAR = %b, O = %b", clk, s, clr, out);

endmodule