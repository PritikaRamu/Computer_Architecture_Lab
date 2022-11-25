module SCDatapath(ALUres, PC, reset, clk, Inst, ReadData1, ReadData2); 
input reset, clk; 
input [31:0] PC; 
output [31:0] ALUres, Inst, ReadData1, ReadData2; 

wire [31:0] WriteData, signnextB, shftsgext, pcalt, ALUInp2, DataMemRead; 
wire RegDst,ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite,Branch,ALUOp1,ALUOp2, cout1, cout2, branch, zero; 
wire [4:0] WriteReg; 
wire [2:0] ALUOp; 

assign WriteData = 32'b0; 
im im(PC, Inst, clk); 
pc pc(PC, clk, reset); 
// assign PC = PC + 4; 
control c(RegDst,ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite,Branch,ALUOp1,ALUOp2, Inst[31:26]); 
bit5_mux2to1_df m1(Inst[20:16], Inst[15:11], RegDst, WriteReg); 
mipsRF rf(clk, reset, Inst[25:21], Inst[20:16], WriteData, WriteReg, RegWrite, ReadData1, ReadData2); 
signext se1(Inst[15:0], signnextB); 
alucontrol aluc({ALUOp1, ALUOp2}, Inst[5:0], ALUOp); 
shiftleft sl1(signnextB, shftsgext); 

bit32_mux2to1_df m2(signnextB, ReadData2, ALUSrc, ALUInp2); 
alu alu(ReadData1, ALUInp2, ALUOp[2], ALUOp[2], ALUOp[1:0], ALUres, cout2, zero); 
adder32_cin badd(PC, shftsgext, 1'b0, pcalt, cout); 
and a1(branch, zero, Branch); 
bit32_mux2to1_df m3(pcalt, PC, branch, PC); 
// bit32_mux2to1_df m4(pcalt, , Jump, PC); 
dm dm(MemRead, MemWrite, clk, ALUres, ALUres, ReadData2, DataMemRead); 
bit32_mux2to1_df m5(ALUres, DataMemRead, MemtoReg, WriteData); 

endmodule 