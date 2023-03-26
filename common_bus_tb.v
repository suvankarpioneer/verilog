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
    localparam stoptime = 170;
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
        #41 CLR[2]= 1'b0;
        #41 INR[2]= 1'b1;
        #45 INR[3]= 1'b1;
        #46 INR[2]= 1'b0;
        #46 INR[3]= 1'b0;
       
        //WRITE OPERATION   
        #46 select = 3'b000;        
        #55 data_in = 16'h0ffe;   //bus takes data from data_in, see if  bus value gets modified immediately at 55ns
        #64 LD[0] = 1'b1;         // addr_reg value will take value of bus at 65ns
        #66 LD[0] = 1'b0;         // addr_bus will take value of addr_reg at 75ns
        #66 data_in = 16'h6789;   //data for bus to main memory
        #74 write = 1'b1;         //  data will be transfered from bus to main memory at 85ns
        // had to wait for 3 clock cycles for data 6789 to be updated on the memory word ffe (4094)
        // addr gets loaded at the bus, then addr gets loaded  to the addr_reg from bus, the addr_reg to addr_bus, 
        //then memory gets updated on the specified addr of ffe.
        // meanwhile data gets loaded to the bus after it transfers the addr. 
        //When write gets high , transfer of bus value to memory takes place after the clock cycle of the addr_reg to addr_bus
        
        #85 data_in = 16'h0ffd;  // data_in will get loaded to bus at 85ns
        #86 write = 1'b0;
        #94 LD[0] = 1'b1;        // addr_reg will get loaded with the value of bus(ffd) at 95ns
        #95 data_in = 16'h1234;  // data for ffd
        #96 LD[0] = 1'b0;        // addr_bus will get loaded with the value of addr_reg at 105ns
        #115 write = 1'b1;       // data 1234 gets loaded to memory at word number ffd at 115ns
        #116 write = 1'b0;
        //IMP: Addr_bus and memory cannot be updated at a single clock edge
        //1st update addr_bus, then update memory
        
        // READ OPERATION
        #125 data_in = 16'h0ffe;    //same operation to update the addr_bus  
        #134 LD[0] = 1'b1;
        #136 LD[0] = 1'b0;          //addr_bus will get updated at 145ns
        #155 read = 1'b1;           //data_bus gets updated with the value from the memory  at 155ns
        #155 select = 3'b111;       // data_bus to bus at 165ns
        //takes 4 cycles to read (1 extra cycle to load data from data_bus to bus)
        #166 read = 1'b0;
    join
endmodule
