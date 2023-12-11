`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module Edgedetect(
    input key,      // 按钮输入
    input clk,      // 时钟信号
    output pulse // 脉冲输出
);

reg key_prev; // 存储前一个按键状态
reg pulse_reg; // always块中储存状态

// 在每个时钟上升沿更新按键状态
always @(posedge clk) begin
    key_prev <= key;
    // 当检测到按键的负沿时，生成脉冲
    if (key_prev & ~key) 
        pulse_reg <= 1;
    else 
        pulse_reg <= 0;
end

assign pulse = pulse_reg;

endmodule
//////////////////////////////////////////////////////////////////////////////////


module Edgedetect(

    );
endmodule
