module isprime #(parameter N=999999)
(
    input clk,rstn,tick,
    input select,
    output [19:0] cnt_20b
);
    reg [19:0]      w_addr;	        //写入的数据的地址
    reg             w_data;	        //写入的数据
    reg             wea;	        //使能端
    reg [19:0]      r_addr;         //读取的数据的地址
    wire            r_data;	        //读取的数据

    reg [19:0]      i;              //外层循环变量
    reg [19:0]      j;              //内层循环变量
    reg             en;
    reg             done;


    reg [19:0]      cnt_temp_reg;
    reg [19:0]      cnt_20b_reg;

    reg [2:0]       timer;
    reg             hold;

always @(posedge clk or negedge rstn) begin
    if(!rstn) begin
        cnt_temp_reg<=(select)?2:N;
        cnt_20b_reg<=(select)?2:N;
        wea<=0;
        i<=2;
        j<=0;
        en<=0;
        done<=0;
        timer<=0;
        hold<=1;
    end
    else if (i*i<=N) begin
        if(en==0)begin
            r_addr<=i;
            if(timer>2)begin
                timer<=0;
                hold<=0;
            end
            else begin
                timer<=timer+1;
                hold<=1;
            end
            if(!hold) begin
                if (r_data==0) begin
                    en<=1;
                    j<=i+i;
                end
                else begin
                    i<=i+1;
                end
            end
        end
        else if(en==1) begin
            if(j<N)begin
                wea<=1;
                w_addr<=j;
                w_data<=1;
                j<=j+i;
            end
            else begin
                wea<=0;
                en<=0;
                i<=i+1;
            end
        end 
    end
    else begin
        done<=1;
        if(done) begin
            if (((cnt_temp_reg<N)&(select))|((cnt_temp_reg>=2)&(~select))) begin
                r_addr<=cnt_temp_reg;
                if(hold) begin
                    if(timer>2)begin
                        timer<=0;
                        hold<=0;
                    end
                    else begin
                        timer<=timer+1;
                    end
                end
                else begin
                    if ((~r_data)&tick) begin
                        cnt_20b_reg<=cnt_temp_reg;
                        cnt_temp_reg<=(select)?cnt_temp_reg+1:cnt_temp_reg-1;
                        hold<=1;
                    end
                    else if ((r_data)) begin
                        cnt_temp_reg<=(select)?cnt_temp_reg+1:cnt_temp_reg-1;
                        hold<=1;
                    end
                    else if((~r_data)&(~tick)) begin
                        cnt_temp_reg<=cnt_temp_reg;
                    end
                end
            end
        end
    end
end
assign cnt_20b=cnt_20b_reg;
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