`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.04.2023 22:32:08
// Design Name: 
// Module Name: gcd
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


module gcd(
    output gt, lt, eq, input clk, sel_in, sel1, sel2, LdA, LdB, input [15:0] data_in
    );
    wire [15:0] A_out, B_out,X,Y,Z, bus;
    PIPO A(bus, LdA,clk, A_out);
    PIPO B(bus, LdB,clk, B_out);
    comparator C1(A_out, B_out, gt, eq, lt);
    subtract S1(X,Y,Z);
    mux X1(sel1, A_out, B_out, X);
    mux Y1(sel2, A_out, B_out, Y);
    mux D1(sel_in, data_in, Z, bus);
endmodule
