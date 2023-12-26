module mode_control
(
    input           clk,
    input           rstn_signal,
    input           one_second,
    input [3:0]     led,
    input [3:0]     key_pulse,
    output          reset,
    output          select,
    output          tick
);

    reg                 tick_r;
    reg                 select_reg;
    reg  [1:0]          reset_r;

    always @(posedge clk) begin
        if(~led[0]) begin
            tick_r <= one_second;
            select_reg<=1;
        end
        else if(~led[1])begin
            tick_r <= one_second;
            select_reg<=0;
        end
        else if(~led[2])begin
            tick_r <= 1;
            select_reg<=1;
        end
        else if(~led[3])begin
            tick_r <= 1;
            select_reg<=0;
        end
        else begin
            tick_r<=0;
        end
    end

    always @(posedge clk) begin
        reset_r<={reset_r[0],(&key_pulse)&rstn_signal};
    end

    assign tick = tick_r;
    assign select=select_reg;
    assign reset=reset_r[1];

endmodule