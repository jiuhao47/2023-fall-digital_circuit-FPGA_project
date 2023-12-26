module ram #(parameter DW=8, AW=10) (
    input clk, we,//时钟输入与使能端
    input [DW-1:0] din,//数据输入
    input [AW-1:0] addr,//地址
    output [DW-1:0] dout //数据输出
);
    reg [AW-1:0] read_addr;//读入地址
    reg [DW-1:0] mem [2**AW - 1:0];//单个单元8位宽，长1024的数组
    assign dout = mem[read_addr]; //数据输出为读取地址
    always @(posedge clk) begin
        if(we) mem[addr] <= din; //we为真，则将输入数值写入addr地址处的内存
        read_addr <= addr;
    end
endmodule

//这里是对BRAM的操作
//如果使用位图数据结构，BRAM看起来也足够使用