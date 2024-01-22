`timescale 1ns/1ps
module test;
  reg clk;
  reg rstn;
  reg [19:0] dividend;
  reg [19:0] divisor;
  wire [19:0] remainder;

remaindercalculator test(
  .clk(clk),
  .rstn(rstn),
  .dividend(dividend),
  .divisor(divisor),
  .remainder(remainder)
);

initial begin
    clk=0;
  forever
    #5 clk = ~clk; // 10ns周期的时钟
end

initial begin
    // 发送复位信号
    rstn = 0;
    #5;
    rstn = 1;

    // 激励测试用例 1: dividend = 50, divisor = 7
    dividend = 20'd50;
    divisor = 20'd7;
    #10;

    // 激励测试用例 2: dividend = 100, divisor = 13
    dividend = 20'd100;
    divisor = 20'd13;
    #10;

    // 激励测试用例 3: dividend = 10, divisor = 2
    dividend = 20'd10;
    divisor = 20'd2;
    #10;

    // 激励测试用例 4: dividend = 20, divisor = 20
    dividend = 20'd20;
    divisor = 20'd20;
    #10;

    // 模拟结束
    $finish();
end

initial begin
    $dumpfile("remainder.vcd");
    $dumpvars(0);
end

endmodule