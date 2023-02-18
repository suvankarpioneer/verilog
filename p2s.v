`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.02.2023 13:40:19
// Design Name: 
// Module Name: p2s
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


module uni_shift_reg(input start, clk, reset, input [7:0] in, output reg outgoing);
reg [1:0] select;
localparam IDLE = 2'b00,
           LOAD = 2'b10,
           SEND = 2'b11;
reg par;
reg [7:0] out;
always@ (posedge clk)
begin
if(!start)
	   begin
	   par <= in[7]^in[6]^in[5]^in[4]^in[3]^in[2]^in[1]^in[0];
	   select<= IDLE;
		case (select)
			IDLE: begin outgoing <= 1'bx;
			            select <= LOAD;
			      end
			LOAD: begin out <= in;
			            select <= SEND;
			      end
			         
			SEND: begin out <= {par,out[7:1]};
			            outgoing <= out[0];
			      end
		endcase
		end
	   
end
	
	
endmodule