`timescale 1ns/1ps
module test ;
    reg clk;
    reg rstn;
    reg tick;
    wire [19:0] cnt_20b;

    isprime dut(.clk(clk),.rstn(rstn),.tick(tick),.cnt_20b(cnt_20b));
initial begin
    clk=0;
    forever begin
        #5 clk=~clk;
    end
end
initial begin
    tick=0;
    forever begin
        #50 tick=~tick;
    end
end
initial begin
    rstn=0;
    #5 rstn=1;
    #50000
    $finish();
end
initial begin
    $dumpfile("isprime.vcd");
    $dumpvars(0);
end
endmodule