`timescale 1ns / 1ps

module uni_shift_reg(input start, clk, input [7:0] in, output reg outgoing, input recieve );
reg [1:0] select;
localparam LOAD = 2'b01,
           SEND = 2'b10;
           
reg par;
reg [4:0] count;
reg [7:0] out;
always@ (negedge clk)
begin
if(start) begin
outgoing <= 1'b1; 
out <= 0; 
select <= 2'bxx;
end
else begin
	   par <= in[7]^in[6]^in[5]^in[4]^in[3]^in[2]^in[1]^in[0];
	   select<= LOAD;
	   outgoing <=1'b1;
	   count <= 0;
		case (select)
			LOAD: begin out <= in;
			            select <= SEND;
			            outgoing <= 1'b0;
			      end
			         
			SEND: begin
			            if(count != 4'b1001) begin
			                 count <= count+1; 
			                 outgoing <= out[0];
			                 out <= {par,out[7:1]};
			                 select <= SEND;
			                 end
			            else outgoing <= 1'b1;
			      end 
			
			      
		endcase
		end
		 
		
	   
end
	
	
endmodule
