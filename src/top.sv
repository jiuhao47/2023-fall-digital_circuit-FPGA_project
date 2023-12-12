module top(
    input clk,
    input rstn,
    output [3:0] led,
    input [3:0] key,
    output [5:0] seg_sel,
    output [7:0] seg_dig
);

    reg [3:0] led;//4-LED 端口

    always @(posedge clk or negedge rstn)
    if(!rstn)
        led <= 0;//复位
    else
        led <= led ^ (~key);//led与key按键对应，key低有效

    reg [23:0] cnt;//24宽通道，计数
    wire [6*8-1:0] seg;//48k宽信号

    always @(posedge clk or negedge rstn)
    if(!rstn)
        cnt <= 0;//计数复位
    else begin
        if(~key[0]) cnt = cnt + 1;
        if(~key[1]) cnt = cnt + 2;
        if(~key[2]) cnt = cnt + 4;
        if(~key[3]) cnt = cnt + 8;//按键功能
    end

    genvar i;
    generate for(i=0; i<6; i=i+1) begin
            led7seg_decode d(cnt[i*4 +: 4], 1'b1, seg[i*8 +: 8]);//+是做什么的？
        end
    endgenerate
    
    seg_driver #(6) driver(clk, rstn, 6'b111111, seg, seg_sel, seg_dig);//数码管驱动

endmodule


//数码管驱动
module seg_driver #(parameter NPorts=8) (
  input clk, rstn, 
  input [NPorts-1:0]    valid_i, // input port valid
  input [NPorts*8-1:0]  seg_i, // segment inputs
  output reg [NPorts-1:0]   valid_o, // output port valid
  output [7:0]          seg_o // segment outputs
);

  reg [14:0] cnt; // 15 位寄存器 cnt，用于计数，0<=cnt<=2^15-1
  always @(posedge clk or negedge rstn) 
    if(~rstn) 
        cnt <= 0;
    else
        cnt <= cnt + 1;

  reg [NPorts-1:0] sel; // NPorts 位（即8位）的寄存器 sel，用于选择当前输入端口
  always @(posedge clk or negedge rstn) 
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

module led7seg_decode(input [3:0] digit, input valid, output reg [7:0] seg);
    //译码器 d to seg
    //digit数据
    //valid使能端
    //seg 输出端
    always @(digit)
    if(valid)
        case(digit)
            0: seg = 8'b00111111;//0
            1: seg = 8'b00000110;//1
            2: seg = 8'b01011011;//2
            3: seg = 8'b01001111;//3
            4: seg = 8'b01100110;//4
            5: seg = 8'b01101101;//5
            6: seg = 8'b01111101;//6
            7: seg = 8'b00000111;//7
            8: seg = 8'b01111111;//8
            9: seg = 8'b01101111;//9
            default: seg = 0;
        endcase
    else seg = 8'd0;
endmodule
