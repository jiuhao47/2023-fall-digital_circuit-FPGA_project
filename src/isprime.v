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
            flag<=0;
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
ram_ip ram_ip_inst 
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



