	
	module DM(
	input [4:0] addr,
	input [31:0] data,
	input reset,
	input memWrite,
	input memRead,
	output [31:0] readData);
		
		reg [31:0] mem [0:31];
		reg [31:0] readData;
		integer j;
		
		always @(memWrite) begin
			if(memWrite)
				mem[addr] = data;
		end
			
		always @(memRead) begin
			if(memRead)
				readData = mem[addr];
		end
			
		always @(reset) begin
			if(reset) begin
				for (j=0; j<32; j=j+1) begin
					mem[j] = 0;
				end
			end
		end
		
	endmodule
