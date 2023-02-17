module uni_shift_reg(input [1:0] select,input MSB_in, LSB_in, clk, reset, input [7:0] in, output reg [7:0] out);
always@ (posedge clk)
begin
if(reset)
	out <= 8'b00000000;
else 
	   begin
		case (select)
			2'b00: out <= out;  // no change
			2'b01: out <= {MSB_in,out[7:1]};
			2'b10: out <= {out[6:0], LSB_in};
			2'b11: out <= in;
			default: out <= 8'b00000000;
		endcase
	   end
end
	
	
endmodule
