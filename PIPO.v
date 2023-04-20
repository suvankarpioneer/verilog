`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.04.2023 22:52:07
// Design Name: 
// Module Name: PIPO
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


module PIPO(
input [15:0] data, input Ld, clk, output [15:0] out
    );
    reg [15:0] store;
    assign out= store;
    always@(posedge clk) begin
        if (Ld==1)store<=data;
        end 
endmodule
