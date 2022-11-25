    module decoder_2to4(
        output [3:0] register,
        input [1:0] regNo);

        assign register[0] = (~regNo[1] & ~regNo[0]), register[1] = (~regNo[1] & regNo[0]), register[2] = (regNo[1] & ~regNo[0]), register[3] = (regNo[1] & regNo[0]); 
        
    endmodule
