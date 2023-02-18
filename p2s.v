`timescale 1ns / 1ps

module uni_shift_reg(input start, clk, reset, input [7:0] in, output reg outgoing);
reg [1:0] select;
localparam IDLE = 2'b00,
           LOAD = 2'b10,
           SEND = 2'b11;
reg par;
reg [4:0] count;
reg [7:0] out;
always@ (negedge clk)
begin
if(reset) begin
outgoing <= 1'bx; 
out <= 0; 
select <= 2'bxx;
end
else begin
    if(!start)
	   begin
	   par <= in[7]^in[6]^in[5]^in[4]^in[3]^in[2]^in[1]^in[0];
	   select<= IDLE;
	   count <= 0;
		case (select)
			IDLE: begin outgoing <= 1'bx;
			            select <= LOAD;
			      end
			LOAD: begin out <= in;
			            select <= SEND;
			      end
			         
			SEND: begin
			            if(count != 4'b1000) begin
			                 count <= count+1; 
			                 outgoing <= out[0];
			                 out <= {par,out[7:1]};
			                 select <= SEND;
			                 end
			            else select <= IDLE;
			      end
		endcase
		end
		 else  begin
                outgoing <= 1'bx; 
                out <= 0; 
                select <= 2'bxx;
                end
		end
	   
end
	
	
endmodule
