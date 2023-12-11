`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module Killshake(
    input clk,        // 时钟信号
    input key,  // 含噪声的按键输入
    output signal  // 清洁的按键输出
);

parameter DEBOUNCE_TIME = 1000000; // 去抖时间阈值，根据时钟频率调整
reg [19:0] count;       // 计数器，位宽取决于DEBOUNCE_TIME
reg key_state;          // 存储稳定后的按键状态
reg signal_reg;         // always块中储存状态

always @(posedge clk) begin
    if (key == key_state) begin
        // 如果当前输入状态与去抖后的状态相同，则增加计数器
        if (count < DEBOUNCE_TIME) 
            count <= count + 1;
        else
            signal_reg <= key_state; // 更新输出状态
    end else begin
        // 如果输入状态改变，重置计数器并更新去抖后的状态
        count <= 0;
        key_state <= key;
    end
end

assign signal = signal_reg;

endmodule

//////////////////////////////////////////////////////////////////////////////////


module Killshake(

    );
endmodule
