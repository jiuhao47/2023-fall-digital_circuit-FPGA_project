module top(
    input clk,
    input rstn,
    output [3:0] led,
    input [3:0] key,
    output [5:0] seg_sel,
    output [7:0] seg_dig
);
    reg [3:0] led_r;//4-LED 端口
    wire key_signal[3:0];
    wire key_pulse[3:0];
    reg state[3:0];
    always @(posedge clk) begin
        if(~rstn) begin
            led_r <= 4'b1111;//复位(全灭)
        end
        else begin
            if(~key_pulse[0])
                led_r = 4'b1110;
            else if(~key_pulse[1])
                led_r = 4'b1101;
            else if(~key_pulse[2])
                led_r = 4'b1011;
            else if(~key_pulse[3])
                led_r = 4'b0111;
        end
    end


    genvar j;
    generate for(j = 0; j < 4; j = j + 1) begin
        Killshake Killshake (clk,key[j],key_signal[j]);
        Edgedetect Edgedetect (key_signal[j],clk,key_pulse[j]);
    end
    endgenerate
    assign led = led_r;

    wire tick;
    Count_to_one_second timer(clk,tick);


    wire [47:0] seg;
    reg [23:0] cnt_20b;
    reg [23:0] cnt_24d;
    reg key_pulse_reg [3:0];

    reg[19:0]       w_addr;	        //写入的数据的地址
    reg             w_data;	        //写入的数据
    reg             wea;	        //使能端
    reg[19:0]       r_addr;         //读取的数据的地址
    wire            r_data;	        //读取的数据

    always @(posedge clk or negedge rstn) begin
    if(!rstn)
        cnt_24d<=2;
    else begin
        key_pulse_reg[0]<=key_pulse[0];
        key_pulse_reg[1]<=key_pulse[1];
        key_pulse_reg[2]<=key_pulse[2];
        key_pulse_reg[3]<=key_pulse[3];
        if(tick) begin
            cnt_24d<=cnt_24d+1;
            wea<=1;
            r_addr<=cnt;
            if(r_data==1) begin
                
            end
        end
        else begin
            wea<=0;
        end
    end
    end
    /*
    reg [23:0] cnt;//24宽通道，计数
    wire [6*8-1:0] seg;//48k宽信号
    
    always @(posedge clk or negedge rstn) begin
    if(!rstn)
        cnt <= 0;//计数复位
    else begin
        key_pulse_reg[0]<=key_pulse[0];
        key_pulse_reg[1]<=key_pulse[1];
        key_pulse_reg[2]<=key_pulse[2];
        key_pulse_reg[3]<=key_pulse[3];
        if(~key_pulse_reg[0]) cnt = cnt + 1;
        if(~key_pulse_reg[1]) cnt = cnt + 2;
        if(~key_pulse_reg[2]) cnt = cnt + 4;
        if(~key_pulse_reg[3]) cnt = cnt + 8;//按键功能
    end
    end
    
    genvar i;
    generate for(i=0; i<6; i=i+1) begin
            led7seg_decode d(cnt[i*4 +: 4], 1'b1, seg[i*8 +: 8]);//+是做什么的？
        end
    endgenerate
    */
    
    //binary_20b_to_bcd_6d transformer(cnt_20b,cnt_24d);//有问题！！！！
    



    genvar i;
    generate for(i=0; i<6; i=i+1) begin
            led7seg_decode d(cnt_20b[i*4 +: 4], 1'b1, seg[i*8 +: 8]);
        end
    endgenerate
    seg_driver #(6) driver(clk, rstn, 6'b111111, seg, seg_sel, seg_dig);//数码管驱动，48宽（6*8）数据显示
    ram_ip ram_ip_inst_2 
(
    .clka      (clk          ),     // input clka
    .wea       (wea          ),     // input [0 : 0] wea
    .addra     (w_addr       ),     // input [19 : 0] addra
    .dina      (w_data       ),     // input [0 : 0] dina
    .clkb      (clk          ),     // input clkb
    .addrb     (r_addr       ),     // input [19 : 0] addrb
    .doutb     (r_data       )      // output [0 : 0] doutb
);
endmodule


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
        pulse_reg <= 0;
    else 
        pulse_reg <= 1;
end

assign pulse = pulse_reg;

endmodule
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////
module Killshake(
    input clk,        // 时钟信号
    input key,  // 含噪声的按键输入
    output signal  // 清洁的按键输出
);

parameter DEBOUNCE_TIME = 1000000; // 去抖时间阈值，根据时钟频率调整,1/50s
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
            10: seg = 8'b01110111;
            11: seg = 8'b01111100;
            12: seg = 8'b00111001;
            13: seg = 8'b01011110;
            14: seg = 8'b01111011;
            15: seg = 8'b01110001;
            default: seg = 0;
        endcase
    else seg = 8'd0;
endmodule


module isprime #(parameter N=1000000)(
    input clk,rstn,
    output over
);
    reg[19:0]       w_addr;	        //写入的数据的地址
    reg             w_data;	        //写入的数据
    reg             wea;	        //使能端
    reg[19:0]       r_addr;         //读取的数据的地址
    wire            r_data;	        //读取的数据

    reg [19:0]      i;              //外层循环变量
    reg [19:0]      j;              //内层循环变量
    reg             en;
    reg             done;
    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            wea<=0;
            i<=2;
            j<=0;
            en<=0;
            done<=0;
        end
        else if (i*i<=N&&(en==0)) begin 
            r_addr<=i;
            if (r_data==1) begin
                en<=1;
            end
            i<=i+1;
        end
        else if(en==1) begin
            j<=i+i;
            if(j<N)begin
                wea<=1;
                w_addr<=j;
                w_data<=0;
                j<=j+i;
            end
            else begin
                wea<=0;
                en<=0;
            end
        end
        else begin
            done<=1;
        end
    end
    assign over=done;
ram_ip ram_ip_inst_1 
(
    .clka      (clk          ),     // input clka
    .wea       (wea          ),     // input [0 : 0] wea
    .addra     (w_addr       ),     // input [19 : 0] addra
    .dina      (w_data       ),     // input [0 : 0] dina
    .clkb      (clk          ),     // input clkb
    .addrb     (r_addr       ),     // input [19 : 0] addrb
    .doutb     (r_data       )      // output [0 : 0] doutb
);
endmodule //isprime



module binary_20b_to_bcd_6d #(parameter N = 20,parameter M = 24) 
(    
	input [N-1:0] input_20b,       
	output [M-1:0] output_6d       
);  
	reg [3:0] digits [0:M-1];       

integer i;    
   initial begin     
	   for (i = 0; i < 6; i = i+1) begin
		   digits[i] = 4'd0;  
     end 
	   for(i = N-1; i >= 0; i = i-1) begin  //加3移位法 
		   if (digits[0] >= 4'b0101) digits[0] = digits[0] + 4'b0011;   
		   if (digits[1] >= 4'b0101) digits[1] = digits[1] + 4'b0011;   
		   if (digits[2] >= 4'b0101) digits[2] = digits[2] + 4'b0011;   
		   if (digits[3] >= 4'b0101) digits[3] = digits[3] + 4'b0011;     
		   if (digits[4] >= 4'b0101) digits[4] = digits[4] + 4'b0011;    
		   if (digits[5] >= 4'b0101) digits[5] = digits[5] + 4'b0011;    

		   digits[5][3:0] = {digits[5][2:0], digits[4][3]};  
		   digits[4][3:0] = {digits[4][2:0], digits[3][3]};  
		   digits[3][3:0] = {digits[3][2:0], digits[2][3]};    
		   digits[2][3:0] = {digits[2][2:0], digits[1][3]};  
		   digits[1][3:0] = {digits[1][2:0], digits[0][3]};   
		   digits[0][3:0] = {digits[0][2:0], input_20b[i]};   
	end  
end	    
	assign output_6d ={digits[5],digits[4],digits[3],digits[2],digits[1],digits[0]};   
endmodule 

module Count_to_one_second #(parameter Count_To = 50_000_000)(
    input clk,
    output one_second
);

reg [31:0] counter;
reg one_second_r;

always @(posedge clk) begin
    if((counter < Count_To) && ~one_second_r) begin
        counter <= counter + 1;
    end
    else if((counter < Count_To) && one_second_r) begin
        one_second_r <= 0;
        counter <= counter + 1;
    end
    else begin
        counter <= 0;
        one_second_r <= 1;
    end
end

assign one_second = one_second_r;

endmodule



