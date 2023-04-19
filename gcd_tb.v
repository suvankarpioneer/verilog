module gcd_tb(
    );
        parameter stoptime=200;
        reg clk, start;
        reg [15:0] data_in;
        wire gt, eq, lt, sel_in, sel1, sel2, LdA, LdB, done;
        gcd_controller GCU1(clk, start, gt, eq, lt, sel_in, sel1, sel2, LdA, LdB, done );
        gcd_datapath GCD1(gt, lt, eq, sel_in, sel1, sel2, LdA, LdB, data_in );
        initial begin
            clk=0;
            forever #5 clk=~clk;
            end
        initial
        fork
            #0 start=0;
            #0 data_in = 16'h5454;
            #3 start=1;
            #13 data_in=16'h1089;
        join
        initial #stoptime $finish;
endmodule
