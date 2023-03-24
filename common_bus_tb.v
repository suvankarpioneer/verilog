`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.03.2023 22:45:01
// Design Name: 
// Module Name: common_bus_tb
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


module commonBus_tb(

    );
    reg clock, read, write;
    reg [5:0] LD; reg [4:0] INR, CLR; 
    reg [2:0] select;
    reg [15:0] data_in;
    reg enable;
    wire [15:0] data_out;
    localparam stoptime = 70;
    common_bus cb1(.clock(clock), .read(read), .write(write), .LD(LD), .INR(INR), .CLR(CLR) ,
    .select(select), .data_in(data_in), .enable(enable), .data_out(data_out) );
    initial #stoptime $finish;
    initial begin
        clock = 1'b1;
        forever begin #5 clock = ~clock; end
        end
    initial fork
        #0 select = 3'b000;
        #0 data_in = 16'h1234;
        #13 LD[2] = 1'b1; // at #5 data will get assigned to data_reg
        #17 data_in = 16'habcd;
        #17 LD[2] = 1'b0;
        #17 LD[3] = 1'b1;
        #26 LD[3] = 1'b0;
        #26 select = 3'b100;  // see for #15 as well, to evaluate if abcd gets assigned to bus and acc. 
                              // at the same time or not; or bus value remains at 1234 
                              // It was seen that assignment doesnt happen at the same time and 
        #26 CLR[2] = 1'b1;
        #33 LD[3] = 1'b1;     //keeping LD[3](for bus to acc.) high and select at 100(for acc. to bus ) at all times will make the
                              //values toggle between acc. and bus
        #36 LD[3] = 1'b0;
        #41 CLR[2]<= 1'b0;
        #41 INR[2]<= 1'b1;
    join
    
endmodule
