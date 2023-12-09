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
            default: seg = 0;
        endcase
    else seg = 8'd0;
endmodule
