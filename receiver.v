`timescale 1ns / 1ps
module receiver(
input in, clk, output reg [7:0] out
    );
reg [1:0] state;
reg [8:0] temp;
reg par ;
reg resend;
reg [3:0] count;
localparam IDLE = 2'b00,
           START = 2'b01,
           GENERATE = 2'b10,
           COMPARE = 2'b11;
          
always @(negedge clk)
begin
    count <= 0;
    state <= IDLE;
    case(state)
    IDLE: begin
        if(!in)begin
            state <= START;
            temp <= 9'bxxxxxxxxx;
        end
    end
    START: begin if (count != 4'b1001)
                            begin
                            count <= count + 1;
                            temp[count]<=in;
                            state <= START;
                            end
                 else begin
                        par <= temp[7]^temp[6]^temp[5]^temp[4]^temp[3]^temp[2]^temp[1]^temp[0];     
                        state <= COMPARE;  
                      end   
           end 
            
    COMPARE: begin 
                if(temp[8]==par) begin
                                     out <= temp;
                                     state <= IDLE;
                                 end
                else begin resend<= 1'b1;
                           out <= 8'bxxxxxxxx;
                           state <= IDLE;
                     end
             
             end
                   
    endcase
end
endmodule
