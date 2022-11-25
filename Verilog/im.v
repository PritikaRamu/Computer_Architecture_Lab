
	module im(inst, pc, clk);
		input [31:0] pc;
		input clk;
		output [31:0] inst;
		reg [31:0] mem[0:31];		//32 mem locns each 32 bit wide
		reg [31:0] inst;
		
		integer addr;

		initial begin
			mem[0] = 32'h00000000;
			mem[1] = 32'h00000000;
			mem[2] = 32'h00000000;
			mem[3] = 32'b10001100000100010000000000001000;
			mem[4] = 32'b10001100000100100000000000000100;
			mem[5] = 32'b00000010001100100100000000100000;
		end
				
		always @(posedge clk) begin
			addr = pc[31:0];
			inst = mem[addr/4];
		end	
		
	endmodule
