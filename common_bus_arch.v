`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.03.2023 21:52:18
// Design Name: 
// Module Name: common_bus_arch
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


module common_bus_arch(
input clock, read, write, input [5:0] LD, input [4:0] INR, CLR , 
input [2:0] select 
    );
    reg [15:0] main_memory [4095:0];
    reg [11:0] program_counter;
    reg [11:0] address_reg;
    reg [15:0] instruction_reg;
    reg [15:0] accumulator;
    reg [15:0] data_reg;
    reg [15:0] temporary_register;
    reg [15:0] bus;
    reg [11:0] addr_bus;
    reg [15:0] data_bus;
    reg [11:0] temp1;
    reg [15:0] temp2;
    
    always @(negedge clock)
    begin
    temp1<= 0;
    temp2<= 0;
    addr_bus<=address_reg;
  
    
        case (select)
            3'b000: bus <= 4'h0000;
            3'b001: bus <=address_reg;                      //0 for address reg
            3'b010: bus <=program_counter;                  //1 for PC
            3'b011: bus <=data_reg;                         //2 for DR
            3'b100: bus <=accumulator;                      //3 for Acc
            3'b101: bus <=instruction_reg;
            3'b110: bus <=temporary_register;
            3'b111: bus <=data_bus;
            
        endcase
    end
   
    always @(negedge clock)
    begin
    addr_bus<=address_reg;
        if(LD[0]) address_reg<=bus;
        if(LD[1]) program_counter<=bus;
        if(LD[2]) data_reg<=bus;
        if(LD[3]) accumulator<=bus;
        if(LD[4]) instruction_reg<=bus;
        if(LD[5]) temporary_register<=bus;
        if(CLR[0]) address_reg<=temp1;
        if(CLR[1]) program_counter<=temp1;
        if(CLR[2]) data_reg<=temp2; 
        if(CLR[3]) accumulator<=temp2;
        if(CLR[4]) temporary_register<=temp2;
        if(INR[0]) address_reg<=address_reg+1;
        if(INR[1]) program_counter<=program_counter+1;
        if(INR[2]) data_reg<=data_reg+1;
        if(INR[3]) accumulator<=accumulator+1;
        if(INR[4]) temporary_register<=temporary_register+1;
        if(read)
            data_bus<=main_memory[addr_bus];
        if(write)
            main_memory[addr_bus]<=data_bus;
    end
endmodule
