`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.04.2023 22:42:20
// Design Name: 
// Module Name: comparator
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


module comparator(
input [15:0] A, B, output gt, eq, lt
    );
    assign gt= (A>B)? 1:0;
    assign eq= (A==B)? 1:0;
    assign lt= (A<B)? 1:0;
endmodule
