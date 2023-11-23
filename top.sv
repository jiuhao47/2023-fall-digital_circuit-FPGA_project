module top(
    input clk,
    input rstn,
    output [3:0] led,
    input [3:0] key,
    output [5:0] seg_sel,
    output [7:0] seg_dig
);

    reg [3:0] led;

    always @(posedge clk or negedge rstn)
    if(!rstn)
        led <= 0;
    else
        led <= led ^ (~key);

    reg [23:0] cnt;
    wire [6*8-1:0] seg;

    always @(posedge clk or negedge rstn)
    if(!rstn)
        cnt <= 0;
    else begin
        if(~key[0]) cnt = cnt + 1;
        if(~key[1]) cnt = cnt + 2;
        if(~key[2]) cnt = cnt + 4;
        if(~key[3]) cnt = cnt + 8;
    end

    genvar i;
    generate for(i=0; i<6; i=i+1) begin
            led7seg_decode d(cnt[i*4 +: 4], 1'b1, seg[i*8 +: 8]);
        end
    endgenerate
    
    seg_driver #(6) driver(clk, rstn, 6'b111111, seg, seg_sel, seg_dig);

endmodule

module seg_driver #(parameter NPorts=8) (
    input clk, rstn,
    input [NPorts-1:0]   valid_i, // input port valid
    input [NPorts*8-1:0] seg_i, // segment inputs
    output reg [NPorts-1:0]  valid_o, // output port valid
    output [7:0]         seg_o // segment outputs
);

    reg [14:0] cnt;
    always @(posedge clk or negedge rstn)
    if(~rstn)
        cnt <= 0;
    else
        cnt <= cnt + 1;

    reg [NPorts-1:0] sel;
    always @(posedge clk or negedge rstn)
    if(~rstn)
        sel <= 0;
    else if(cnt == 0)
        sel <= sel == NPorts - 1 ? 0 : sel + 1;

    always @(sel, valid_i) begin
        valid_o = {NPorts{1'b1}};
        valid_o[sel] = ~valid_i[sel];
    end

    assign seg_o = ~seg_i[sel*8+:8];

endmodule

module led7seg_decode(input [3:0] digit, input valid, output reg [7:0] seg);

    always @(digit)
    if(valid)
        case(digit)
            0: seg = 8'b00111111;
            1: seg = 8'b00000110;
            2: seg = 8'b01011011;
            3: seg = 8'b01001111;
            4: seg = 8'b01100110;
            5: seg = 8'b01101101;
            6: seg = 8'b01111101;
            7: seg = 8'b00000111;
            8: seg = 8'b01111111;
            9: seg = 8'b01101111;
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
