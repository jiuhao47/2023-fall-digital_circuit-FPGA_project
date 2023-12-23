module isprime #(parameter N=999999)(
    input clk,rstn,tick,
    output [19:0] cnt_20b
);
    reg[1000000:0] ram;
    reg[19:0]       w_addr;	        //写入的数据的地址
    reg             w_data;	        //写入的数据
    reg             wea;	        //使能端
    reg[19:0]       r_addr;         //读取的数据的地址
    wire            r_data;	        //读取的数据

    reg [19:0]      i;              //外层循环变量
    reg [19:0]      j;              //内层循环变量
    reg             en;
    reg             done;

    reg [19:0]      cnt_temp_reg;
    reg [19:0]      cnt_20b_reg;
    
    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            cnt_20b_reg<=2;
            cnt_temp_reg<=2;
            i<=2;
            j<=0;
            en<=0;
            done<=0;
            wea<=0;
            ram=0;
            w_addr=0;
            w_data=0;
            r_addr=0;
        end
        else if (i*i<=N) begin 
            if(en==0)begin
                r_addr<=i;
                if (ram[i]==0) begin
                    en<=1;
                    j<=i+i;
                end
                else begin
                    i<=i+1;
                end
                //i<=i+1;???
            end
            else if(en==1) begin
                //j<=i+i;
                if(j<N)begin
                    wea<=1;
                    w_addr<=j;
                    w_data<=1;
                    ram[j]=1;
                    //j<=j+i;????
                end
                else begin
                    wea<=0;
                    en<=0;
                    i<=i+1;
                end
                j<=j+i;
            end 
        end
        else begin
                //wea<=1;
                done<=1;
                if(done) begin
                    if (cnt_temp_reg<N) begin
                        r_addr<=cnt_temp_reg;
                    if ((~ram[cnt_temp_reg])&tick) begin
                        cnt_20b_reg<=cnt_temp_reg;
                        cnt_temp_reg<=cnt_temp_reg+1;
                    end
                    else if ((ram[cnt_temp_reg])) begin
                        cnt_temp_reg<=cnt_temp_reg+1;
                    end
                    else if((~ram[cnt_temp_reg])&(~tick)) begin
                        cnt_temp_reg<=cnt_temp_reg;
                    end
                end
            end
        end
    end
    assign cnt_20b=cnt_20b_reg;
endmodule //isprime