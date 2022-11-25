`timescale 1us / 1ps

module ControlLogic (S,Z,X,CLK,T0,T1,T2);
    input S, Z, X, CLK;
    output T0, T1, T2;
    wire d0, d1, d2;
    wire s_, t2z, t0s, t2z_, t2x_z_, t1x_, t1x, t2z_x;
    wire x_, z_;
    wire or1;

    not (s_,S);
    and (t0s_,T0,s_);
    and (t2z, T2, Z);
    or (d0, t0s_, t2z);
    d_ff dff1(CLK,1'b0,d0,T0);

    and (t0s, T0, S);
    not (z_, Z);
    and (t2z_, T2, z_);
    not (x_, X);
    and (t2x_z_, x_, t2z_);
    and (t1x_, T1, x_);
    or (or1, t0s, t2x_z_);
    or (d1, or1, t1x_);
    d_ff dff2(CLK,1'b0,d1,T1);

    and (t1x, T1, X);
    and (t2z_x,t2z_,X);
    or (d2, t1x, t2z_x);
    d_ff dff3(CLK,1'b0,d2,T2);

endmodule

module d_ff(clk, rst, d, q);
    input clk, rst, d;
    output q;
    reg q;
    always @(posedge clk)
    begin
        if(rst)
        begin
            q = 1'b0;
        end 
        else
        begin
            if(d)
            begin
                q = 1;
            end
            else
            begin
                q = 0;
            end
        end
    end
endmodule  

module t_ff(clk, rst, t, q, en);
    input clk, rst, t, en;
    output q;
    reg q;
    always @(posedge clk)
    begin
        if(rst)
        begin
            q = 1'b0;
        end
    end
    always @(posedge clk&&en)
    begin
        if(rst)
        begin
            q = 1'b0;
        end 
        else
        begin
            if(t)
            begin
                q = ~q;
            end
            else
            begin
                q = q;
            end
        end
    end
endmodule 

module counter(clk,rst, en, q);
    input clk, rst, en;
    output [3:0] q;
    wire [3:0] q;
    wire q0q1;
    wire qq;


    t_ff tff1(clock, rst, 1'b0, q[0], en);
    t_ff tff2(clock, rst, q[0], q[1], en);

    and (q0q1, q[0], q[1]);
    t_ff tff3(clock, rst, q0q1, q[2], en);

    and (qq, q0q1, q[2]);
    t_ff tff4(clock, rst, qq, q[3], en);
endmodule

module INTG(S,X,CLK, q, G);
    input S,X,CLK;
    output G;
    output [3:0] q;
    wire z,a, en, clr;
    wire t0, t1, t2;

    assign en = (t1&&X)||(t2&&X&&(~z));
    assign clr = t0&&S;
    counter co(CLK,clr,en,q);

    assign z = q[0]&&q[1]&&q[2]&&q[3];

    ControlLogic col(S,z,X,CLK,t0,t1,t2);

    assign a = t2&&z;
    d_ff diff(CLK,1'b0,a,G);
endmodule

module testbench;
    reg clk, s,x;
    wire [3:0] q;
    wire g;

    INTG intg(s,x,clk, q, g);

    initial begin
        clk = 0;
        #1 s = 1;
        #1 x = 1;
    end

    initial begin
        forever begin
            #500 clk = ~clk;
            $display("Q= %b%b%b%b",q[3],q[2],q[1],q[0]," G= %b",g);
        end
    end

    initial begin
        #30000 $finish;
    end
endmodule