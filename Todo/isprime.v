module isprime #(parameter N=999999)(
    input clk,rstn,tick,
    output [19:0] cnt_20b
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


    reg [19:0] cnt_temp_reg;
    reg [19:0] cnt_20b_reg;

    reg [2:0] timer;
    reg hold;
    reg [2:0] timer_out;
    reg hold_out;
    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            cnt_20b_reg<=2;
            cnt_temp_reg<=2;
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
                    hold=0;
                end
                else begin
                    timer<=timer+1;
                    hold=1;
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
                //i<=i+1;???
            end
            else if(en==1) begin
                //j<=i+i;
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
                //wea<=1;
                done<=1;
                if(done) begin
                    if (cnt_temp_reg<N) begin
                        r_addr<=cnt_temp_reg;
                        if(timer>2)begin
                            timer<=0;
                            hold=0;
                        end
                        else begin
                            timer<=timer+1;
                            hold=1;
                        end
                    if(!hold) begin
                    if ((~r_data)&tick) begin
                        cnt_20b_reg<=cnt_temp_reg;
                        cnt_temp_reg<=cnt_temp_reg+1;
                    end
                    else if ((r_data)) begin
                        cnt_temp_reg<=cnt_temp_reg+1;
                    end
                    else if((~r_data)&(~tick)) begin
                        cnt_temp_reg<=cnt_temp_reg;
                    end
                    end
                end
            end
        end
    end

    reg [2:0]r_data_reg;
    always @(posedge clk or negedge rstn) begin
        r_data_reg={r_data_reg[1:0],r_data};
    end
    //assign cnt_20b=cnt_temp_reg;
    assign cnt_20b=cnt_20b_reg;
    //assign cnt_20b={done,i[18:0]};
    //assign cnt_20b={19'b0,done};

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