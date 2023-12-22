module memory_output (
  input clk, // 时钟信号
  input rst, // 重置信号
  input anniu,
  input [31:0] memory [0:255], // 存储数字的内存
  output reg [31:0] output_data // 输出的数字
);

  reg [7:0] counter; // 用于计时的计数器
  reg t;
  

  always @(posedge clk or posedge rst) begin
case(anniu)
case1:if (rst) begin
      counter <= 0; // 重置计数器
      t <= 0;
      output_data <= 0; // 初始化输出的数字
    end else begin
      counter <= counter + 1; // 每个时钟周期递增计数器
      if (counter == 50000000) begin // 50,000,000 个时钟周期约等于 1 秒
        // 从内存中读取下一个数字
        output_data <= memory[t]; // 使用计数器的值作为内存地址，并将对应的数字输出
        counter <= 0; // 重置计数器;
               t <= t + 1;
      end
    end


case2:if (rst) begin
      counter <= 0; // 重置计数器
      output_data <= 0; // 初始化输出的数字
    end else begin
      counter <= counter + 1; // 每个时钟周期递增计数器
      if (counter == 50000000) begin // 50,000,000 个时钟周期约等于 1 秒
        // 从内存中读取下一个数字
        output_data <= memory[counter % 256]; // 使用计数器的值作为内存地址，并将对应的数字输出
        counter <= 0; // 重置计数器
      end
    end

//case3:
        //counter <= counter + 1; 
       // output_data <= memory[counter]; 
//case4:
        //counter <= counter + 1; 
        //output_data <= memory[counter]; 
//default:
       
endcase
end 
endmodule
