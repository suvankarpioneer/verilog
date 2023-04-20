`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.04.2023 13:36:28
// Design Name: 
// Module Name: gcd_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module gcd_tb(

    );
        parameter stoptime=300;
        reg clk, start;
        reg [15:0] data_in;
        wire gt, eq, lt, sel_in, sel1, sel2, LdA, LdB, done;
        gcd_cu GCU1(clk, start, gt, eq, lt, sel_in, sel1, sel2, LdA, LdB, done );
        gcd GCD1(gt, lt, eq, clk, sel_in, sel1, sel2, LdA, LdB, data_in );
        initial begin
            clk=0;
            forever #5 clk=~clk;
            end
        initial
        fork
            #0 start=0;
            #0 data_in = 16'h52ad;
            #3 start=1;
            #23 data_in=16'h1089;
        join
        initial #stoptime $finish;
endmodule
