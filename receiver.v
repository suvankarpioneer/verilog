`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.02.2023 00:40:39
// Design Name: 
// Module Name: receiver
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


module receiver(
input in, clk, output [7:0] out
    );
reg [1:0] state;
reg [8:0] temp;
reg par ;
reg [3:0] count;
localparam START = 2'b00;
always @(negedge clk)
begin
    if(!in) begin
        state <= START;
        count <= 0;
        case(state)
            START: begin if (count != 4'b1001)
                            begin
                            count <= count + 1;
                            temp[count]<=in;
                            state <= START;
                            end
                         
                         
                   end
        endcase
    end
end
 
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
endmodule
