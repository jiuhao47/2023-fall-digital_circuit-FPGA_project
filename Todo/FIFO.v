//FIFO 吴尚哲
//时序逻辑设计B.pdf P52
//深度为L，可以先按照PPT的写，要求不穿透（非0最小延时）
module FIFO #(parameter dw=8, L=7)
( input clk, rstn,
  input [dw-1:0] d_in, 
  input req_in, 
  output ack_in,
  output [dw-1:0] d_out, 
  output req_out, 
  input ack_out 
);

  reg [dw-1:0] data [L-1:0]; // 创建一个存储数据的寄存器数组
  reg [L-1:0] valid; // 表示每个存储位置是否有效的寄存器
  reg [L-1:0] wp, rp; // 写指针和读指针

  assign d_out = data[rp]; // 输出读指针指向的数据
  assign req_out = valid[rp]; // 输出读指针指向的数据是否有效
  assign ack_in = ~valid[wp]; // 输入写指针指向的位置是否可用

  always @(posedge clk or negedge rstn)
    if (~rstn) begin // 复位条件
      wp <= 0; rp <= 0; valid <= 0; // 将写指针、读指针和有效性标志位清零
    end else begin
      if (req_in & ack_in) begin // 当输入请求和输入端空闲时
        wp <= (wp == L-1) ? 0 : wp + 1; // 更新写指针
        valid[wp] <= 1'b1; // 标记写指针所指向的位置为有效
        data[wp] <= d_in; // 将输入数据写入对应位置
      end
      if (req_out & ack_out) begin // 当输出请求和输出端空闲时
        rp <= (rp == L-1) ? 0 : rp + 1; // 更新读指针
        valid[rp] <= 1'b0; // 标记读指针所指向的位置为无效（数据已被读取）
      end
    end
endmodule
