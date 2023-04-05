module seq_detector(input clk, x,reset, output reg y);
parameter S0=0, S1=1, S2=2, S3=3, S4=4, S5=5, S6=6;
reg [2:0] PS, NS;
always@(posedge clk) begin
	if(reset)  PS<=S0;
	else PS<=NS;
end
always @(x, PS) begin
    case(PS)
		S0: begin
			y=0;
			NS=x? S1:S0;
		end
		S1: begin
			y=0;
			NS=!x? S2:S0; end
		S2: begin
			y=0;
			NS=x? S3:S0; end
		S3: begin
			y=0;
			NS=!x? S4:S0; end
		S4: begin
			y=0;
			NS=x? S5:S0; end
		S5: begin
			y=!x? 1:0;
			NS=!x? S4:S0;
		end
	endcase
end
endmodule

//test_bench

module seq_tb();
wire y;
reg x, clk, reset;


seq_detector SD1(.x(x), .y(y), .clk(clk), .reset(reset));
initial begin
	$dumpfile("seq_det.vcd");
	$dumvars(0, seq_tb);
	clk = 0; reset = 1;
end
always #5 clk=~clk;
initial begin
	#2 x=0;
	#1 reset=0;
	#10 x=1; #10 x=0; #10 x=1; #10 x=0; #10 x=1; #10 x=0; #10 x=1;
	#10 x=0; #10 x=1; #10 x=1; #10 x=1; #10 x=0; #10 $finish;
	
end
endmodule
