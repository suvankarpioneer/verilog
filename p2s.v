`timescale 1ns / 1ps

module uart(input start, clk, input [7:0] in,input receive, output reg Tx, output reg [7:0] Rx);

localparam LOAD = 2'b01,
           SEND = 2'b10,
           IDLE = 2'b00,
           START = 2'b01,
           GENERATE = 2'b10,
           COMPARE = 2'b11;
reg [1:0] select;      
reg par_Tx;
reg [3:0] count;
reg [7:0] out;
reg [1:0] state;
reg [8:0] temp;
reg par_Rx ;
reg resend;
reg [3:0] count1; 
always@ (negedge clk)
begin
if(start) begin
Tx <= 1'b1; 
out <= 0; 
select <= 2'bxx;
end
else begin
	   par_Tx <= in[7]^in[6]^in[5]^in[4]^in[3]^in[2]^in[1]^in[0];
	   select<= LOAD;
	   Tx <=1'b1;
	   count <= 0;
		case (select)
			LOAD: begin out <= in;
			            select <= SEND;
			            Tx <= 1'b0;
			      end
			         
			SEND: begin
			            if(count != 4'b1001) begin
			                 count <= count+1; 
			                 Tx <= out[0];
			                 out <= {par_Tx,out[7:1]};
			                 select <= SEND;
			                 end
			            else Tx <= 1'b1;
			      end 
			
			      
		endcase
		end
end
always @(negedge clk)
begin
    count1 <= 0;
    state <= IDLE;
    case(state)
    IDLE: begin
        if(!receive)begin
            state <= START;
            temp <= 9'bxxxxxxxxx;
            par_Rx<=1'bx;
            Rx<= 8'bxxxxxxxx;
        end
    end
    START: begin if (count1 != 4'b1001)
                            begin
                            count1 <= count1 + 1;
                            temp[count1]<=receive;
                            state <= START;
                            end
                 else begin
                        par_Rx <= temp[7]^temp[6]^temp[5]^temp[4]^temp[3]^temp[2]^temp[1]^temp[0];     
                        state <= COMPARE;  
                      end   
           end 
            
    COMPARE: begin 
                if(temp[8]==par_Rx) begin
                                     Rx <= temp;
                                     state <= IDLE;
                                 end
                else begin resend<= 1'b1;
                           Rx <= 8'bxxxxxxxx;
                           state <= IDLE;
                     end
             
             end
                   
    endcase
end
endmodule
