module DECODER(d0,d1,d2,d3,d4,d5,d6,d7,x,y,z);
	input x,y,z;
	output d0,d1,d2,d3,d4,d5,d6,d7;
	wire x0,y0,z0;
	not n1(x0,x);
	not n2(y0,y);
	not n3(z0,z);
	and a0(d0,x0,y0,z0);
	and a1(d1,x0,y0,z);
	and a2(d2,x0,y,z0);
	and a3(d3,x0,y,z);
	and a4(d4,x,y0,z0);
	and a5(d5,x,y0,z);
	and a6(d6,x,y,z0);
	and a7(d7,x,y,z);
endmodule

module FADDER(s,c,x,y,z);
	input x,y,z;
	wire d0,d1,d2,d3,d4,d5,d6,d7;
	output s,c;
	DECODER dec(d0,d1,d2,d3,d4,d5,d6,d7,x,y,z);
	assign s = d1 | d2 | d4 | d7,
	c = d3 | d5 | d6 | d7;
endmodule

// module testbench_fadder;
// 	 reg x,y,z;
// 	 wire s,c;
// 	 FADDER fl(s,c,x,y,z);
// 	 initial
// 	 $monitor(,$time,"x=%b,y=%b,z=%b,s=%b,c=%b",x,y,z,s,c);
// 	 initial
// 	 begin
// 	 #0 x=1'b0;y=1'b0;z=1'b0;
// 	 #4 x=1'b1;y=1'b0;z=1'b0;
// 	 #4 x=1'b0;y=1'b1;z=1'b0;
// 	 #4 x=1'b1;y=1'b1;z=1'b0;
// 	 #4 x=1'b0;y=1'b0;z=1'b1;
// 	 #4 x=1'b1;y=1'b0;z=1'b1;
// 	 #4 x=1'b0;y=1'b1;z=1'b1;
// 	 #4 x=1'b1;y=1'b1;z=1'b1;
// 	 end
// endmodule


//Comparator 
 
module signa(neg,A);  
//this module is used to get the sign of an input 4-digit number   
	input  [3:0] A;   
	output neg; 
	reg neg; 
	
	always @ (A) 
		if (A[3] == 1) 
	begin    
	neg =1; 
	end 
	else 
	neg =0; 
 
endmodule 
//***************************************************************
module compar(A,B,CMP1, CMP2,CMP3);   
//This module implement the compare code for input of two 3-digit numbers using signa(). 
input  [3:0] A;   
input  [3:0] B;   
output CMP1,CMP2,CMP3;
wire signA,signB;
reg CMP1,CMP2,CMP3;  
signa forA(signA,A); 
signa forB(signB,B); 
 
always  @  (A  or  B  or  signA  or  signB)//  performs  check  for  four different cases 
   
if(signA==1 && signB==0) 
begin 
 	CMP1 = 0; 
    CMP2 = 0; 
    CMP3 = 1; 
end 
  
 else if(signA==0 && signB==1) 
  begin       
 CMP1 = 1; 
    CMP2 = 0; 
    CMP3 = 0; 
 end    
  
 else if (A > B  ) 
    begin       
  CMP1 = 1; 
        CMP2 = 0; 
        CMP3 = 0; 
   end    
  
  else if (A == B) 
  begin       
  CMP1 = 0; 
        CMP2 = 1; 
        CMP3 = 0; 
   end    
  
  else 
  begin       
  CMP1 = 0; 
        CMP2 = 0; 
        CMP3 = 1; 
   end    
  endmodule  
//*************************************************************** 
module testbench; 
//This module tests the functionality of compare() module 
 reg Input,Clk; 
 wire Out; 
 reg [3:0] A; 
 wire a,b,c,OutA,OutB,CMP1,CMP2,CMP3; 
 reg [3:0] B; 
  
     initial 
      begin 
  A=4'b0000;//input1 
  B=4'b0000;//input2 
 end 
  
initial 
 begin 
  #1 A=-8;B=-5; 
  #1 A=2; B=7; 
  #1 A=5; B=-1; 
end   
 compar c1(A,B,CMP1,CMP2,CMP3);  //make an instance of compar() 
initial  
 begin 
$monitor($time,"A=%b, B=%b AgrB=%b, AeqB=%b, AltB=%b",A,B,CMP1,CMP2,CMP3); 
end 
  
initial 
 begin 
 #5 $finish; 
end  
endmodule