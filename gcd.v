// greatest common divisor datapath

module gcd_datapath(
    output gt, lt, eq, input sel_in, sel1, sel2, LdA, LdB, input [15:0] data_in 
    );
    wire [15:0] A_out, B_out,X,Y,Z, bus;
    PIPO A(bus, LdA, A_out);
    PIPO B(bus, LdB, B_out);
    comparator C1(A_out, B_out, gt, eq, lt);
    subtract S1(X,Y,Z);
    mux X1(sel1, A_out, B_out, X);
    mux Y1(sel2, A_out, B_out, Y);
    mux D1(sel_in, data_in, Z, bus);
endmodule

module comparator(
input [15:0] A, B, output gt, eq, lt
    );
    assign gt= (A>B)? 1:0;
    assign eq= (A==B)? 1:0;
    assign lt= (A<B)? 1:0;
endmodule

module mux(
input select, input [15:0] in1, in2, output [15:0] out
    );
    assign out= select? in1:in2;
endmodule

module PIPO(
input [15:0] data, input Ld, output [15:0] out
    );
    reg [15:0] store;
    assign out= store;
    always@(Ld) begin
        if (Ld==1)store<=data;
        end 
endmodule

module subtract(
input [15:0] A, B, output [15:0] out
    );
    assign out = A-B;
endmodule


// greatest common divisor controller

module gcd_controller(
input clk, start, gt, eq, lt, output reg sel_in, sel1, sel2, LdA, LdB, done
    );
    
    parameter S0=3'd0, S1=3'd1,S2=3'd2,S3=3'd3,S4=3'd4,S5=3'd5;
    reg [2:0] state;
    always@(negedge clk) begin
        if (start) begin
            state<=S0;
            case(state)
            S0: state<=S1;
            S1: state<=S2;
            S2: begin
                if (eq) state<= S5; 
                if (gt) state<= S3;
                if (lt) state<= S4;
                end    
            S3: state<=S2;
            S4: state<=S2;
            S5: state<=S5;
            default: state<=S0;
            endcase
        end
    end
    always@(state)begin
        case(state)
        S0: begin 
           
               done=0;
               LdA=1; 
               LdB=0;
               sel_in=1;
            
        end
        S1: begin
                LdA=0;
                LdB=1;
        end
         
        S3: begin
                sel1=1;
                sel2=0;
                sel_in= 0;
          	    #1 LdA=1;
                LdB=0;
        
        end
        S4: begin
                sel1=0;
                sel2=1;
                sel_in=0;
                #1 LdA=0;
                LdB=1;
        
        end
        
        S5: done=1;
        endcase
    
    end
endmodule


