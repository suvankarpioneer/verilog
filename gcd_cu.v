`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.04.2023 23:19:41
// Design Name: 
// Module Name: gcd_cu
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


module gcd_cu(
input clk, start, gt, eq, lt, output reg sel_in, sel1, sel2, LdA, LdB, done
    );
    
    parameter S0=3'b000, S1=3'b001, S2=3'b010, S3=3'b011, S4=3'b100, S5=3'b101;
    reg [2:0] state;
    always@(posedge clk) begin
        case(state)
            S0: begin
                    if(start) state<=S1;
                    else state<=S0;
                end
            S1: state<=S2;
            S2: begin
                    #2 if(eq) state<=S5;
                    else if(gt) state<=S3;
                    else if(lt) state<=S4;
                end
            S3: begin
                    #2 if(eq) state<=S5;
                    else if(gt) state<=S3;
                    else if(lt) state<=S4;
                end 
            S4: begin
                    #2 if(eq) state<=S5;
                    else if(gt) state<=S3;
                    else if(lt) state<=S4;
                end 
            S5: state<=S5;
            default: state<=S0;
        endcase
    end    
    
    
    always@(state) begin
        case(state)
            S0: begin
                    done=0;
                    sel_in=1;
                    LdA=1;
                    LdB=0;
                end
            S1: begin
                    LdA=0;
                    LdB=1;
                end
            S2: begin
                    if(eq) done=1;
                    else if(gt) begin
                        sel1=1;
                        sel2=0;
                        sel_in=0;
                        #1 LdB=0;
                        LdA=1;
                        end
                    else if(lt) begin
                        sel1=0;
                        sel2=1;
                        sel_in=0;
                        #1 LdB=1;
                        LdA=0;
                        end
                end
            S3: begin
                    if(eq) done=1; 
                    else if(gt) begin
                        sel1=1;
                        sel2=0;
                        sel_in=0;
                        #1 LdB=0;
                        LdA=1;
                        end
                    else if(lt) begin
                        sel1=0;
                        sel2=1;
                        sel_in=0;
                        #1 LdB=1;
                        LdA=0;
                        end
                end
            S4: begin
                    if(eq) done=1; 
                    else if(gt) begin
                        sel1=1;
                        sel2=0;
                        sel_in=0;
                        #1 LdB=0;
                        LdA=1;
                        end
                    else if(lt) begin
                        sel1=0;
                        sel2=1;
                        sel_in=0;
                        #1 LdB=1;
                        LdA=0;
                        end
                end        
            S5: begin
                    done=1; LdA=0; LdB=0; sel_in=0; sel1=0; sel2=0;  
                end 
        endcase             
    end   
    
endmodule
