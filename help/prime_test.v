`timescale 1ns/1ps

module test;
    reg clk;
    wire [20:0] prime;

module_prime dut (
    .clk(clk),
    .temp_prime(prime)
);

initial begin
    clk=0;
    forever begin
        #5 clk=~clk;
    end
end

initial begin
	#100000 
	$finish();
end
/*  
always @(*) begin
      $display("%d", prime);
end
*/
initial begin
    $dumpfile("prime.vcd");
    $dumpvars(0);
end
endmodule