//LED显示器 吴尚哲
//时序逻辑设计B-实验.pdf P14
//top.sv seg_driver模块
//拷贝过来，并且给各部分写注释，使代码可读性增强
module seg_driver #(parameter NPorts=8) (
  input clk, rstn, 
  input [NPorts-1:0]    valid_i, // input port valid
  input [NPorts*8-1:0]  seg_i, // segment inputs
  output reg [NPorts-1:0]   valid_o, // output port valid
  output [7:0]          seg_o // segment outputs
);

  reg [14:0] cnt; // 15 位寄存器 cnt，用于计数
  always @(posedge clk or negedge rstn) // clk上升沿和rstn下降沿触发的always块
    if(~rstn) 
        cnt <= 0;
    else
        cnt <= cnt + 1;

  reg [NPorts-1:0] sel; // NPorts 位（即8位）的寄存器 sel，用于选择当前输入端口
  always @(posedge clk or negedge rstn) // clk上升沿和rstn下降沿触发的always块
    if(~rstn)
        sel <= 0;
    else if(cnt == 0)
      sel <= (sel == NPorts - 1) ? 0 : sel + 1; // 若条件(sel == NPorts - 1)为真，将sel赋值为0，否则sel+1，循环刷新

  always @(sel, valid_i) begin // 使用 sel 和 valid_i 作为敏感信号的 always 块
    valid_o = {NPorts{1'b1}}; // 初始化 valid_o 为全 1 的向量，表示所有输出端口有效
    valid_o[sel] = ~valid_i[sel]; // 取反当前选择的输入端口的有效性，表示相应输出端口的有效性
    end

  assign seg_o = ~seg_i[sel*8+:8]; //取反从sel_i寄存器索引开始选择的8位数据段，赋值给 seg_o

endmodule
