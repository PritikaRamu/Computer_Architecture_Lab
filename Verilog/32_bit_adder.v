module bit32_adder( sum,  cout,num1, num2,  cin );
    input [31:0] num1, num2;
    input cin;
    output cout;
    output [31:0] sum;
    assign {cout,sum} = num1+num2+cin;

endmodule

// module tb;
//     reg [31:0] n1;
//     reg [31:0] n2;
//     reg cin;

//     wire sum, cout;

//     bit32_adder a(sum,cout,n1,n2,cin);

//     initial begin
//         n1 = 32'b0;
//         n2 = 32'd10;
//         cin = 1'b1;
//         #5 $display("%b",cout," %b",sum);
//     end