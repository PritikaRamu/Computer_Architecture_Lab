module d_ff(q,d,clock,reset);
		input d, reset, clock;
		output q;
		reg q;
		
		always @(posedge clock or negedge reset)
			begin
				if(reset)
					q = d;
				else
					q = 1'b0;
			end
	endmodule
