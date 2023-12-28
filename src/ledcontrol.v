module ledcontrol
(
    input           clk,
    input           rstn_signal,
    input  [3:0]    key_pulse,
    output [3:0]    led
);

    reg    [3:0]    led_r;
    always @(posedge clk or negedge rstn_signal) begin
        if(~rstn_signal) begin
            led_r <= 4'b1110;//初始状态
        end
        else if(~key_pulse[0]) begin
            led_r <= 4'b1110;
        end
        else if(~key_pulse[1]) begin
            led_r <= 4'b1101;
        end
        else if(~key_pulse[2]) begin
            led_r <= 4'b1011;
        end
        else if(~key_pulse[3]) begin
            led_r <= 4'b0111;
        end
    end    
    assign led = led_r;
endmodule