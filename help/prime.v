module module_prime(
    input clk,
    output reg [20:0] temp_prime
);

reg [999999:0] sieve;
integer i, j;
reg found_new_prime; // 新素数标志 
wire [20:0] prime;

initial begin
    sieve = 1; // 初始化所有数都为素数
    
    for (i = 2; i <= 1000; i = i + 1) begin
        if (sieve[i]) begin
            for (j = i * i; j <= 1000000; j = j + i) begin
                sieve[j] = 0; // 将 i 的倍数标记为合数
            end
        end
    end

    temp_prime = 21'b00000000000000010; 
end

always @(posedge clk) begin
    found_new_prime = 0;
    for (i = temp_prime + 1; i <= 1000000; i = i + 1) begin
        if (sieve[i]) begin
            temp_prime = i;
            found_new_prime = 1;
        end
    end
end

endmodule