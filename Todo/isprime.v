module isprime #(parameter N=999999,DW=8)(
    input clk,rstn,
    input [DW:0] digit_in,
    output [DW:0] digit 
);
    reg [19:0] cnt;
    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            cnt <=2;
        end
        if(cnt <=N) begin
            cnt<=cnt+1;
        end
    end

endmodule


module ram1 #(parameter DW=8, AW=10) (
    input clk, we,//时钟输入与
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


module ram2
(
input            clk,           //system clock 50Mhz on board
input            rst_n          //reset ,low active
);

reg[19:0]        w_addr;	        //写入的数据的地址
reg       w_data;	        //写入的数据
reg             wea;	        //使能端
reg[19:0]        r_addr;         //读取的数据的地址
wire      r_data;	         //读取的数据
/*
always @(posedge clk or negedge rst_n)
  if(rst_n==1'b0) 
	   r_addr <= 9'd0;
  else 
      r_addr <= r_addr+1'b1;

always@(posedge clk or negedge rst_n)
begin	
  if(rst_n==1'b0) begin
  	  wea <= 1'b0;
     w_addr <= 9'd0;
	  w_data <= 16'd0;
  end
  else begin
     if(w_addr==511) begin    //write ram end
        wea <= 1'b0;                 
     end
     else begin                    
        wea<=1'b1;              //write ram enable
		  w_addr <= w_addr + 1'b1;
		  w_data <= w_data + 1'b1;
	  end
  end 
end 
*/

ram_ip ram_ip_inst 
(
.clka      (clk          ),     // input clka
.wea       (wea          ),     // input [0 : 0] wea
.addra     (w_addr       ),     // input [8 : 0] addra
.dina      (w_data       ),     // input [15 : 0] dina
.clkb      (clk          ),     // input clkb
.addrb     (r_addr       ),     // input [8 : 0] addrb
.doutb     (r_data       )      // output [15 : 0] doutb
);
endmodule