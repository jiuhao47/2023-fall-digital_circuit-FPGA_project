`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module Killshake(
    input clk,        // ʱ���ź�
    input key,  // �������İ�������
    output signal  // ���İ������
);

parameter DEBOUNCE_TIME = 1000000; // ȥ��ʱ����ֵ������ʱ��Ƶ�ʵ���
reg [19:0] count;       // ��������λ��ȡ����DEBOUNCE_TIME
reg key_state;          // �洢�ȶ���İ���״̬
reg signal_reg;         // always���д���״̬

always @(posedge clk) begin
    if (key == key_state) begin
        // �����ǰ����״̬��ȥ�����״̬��ͬ�������Ӽ�����
        if (count < DEBOUNCE_TIME) 
            count <= count + 1;
        else
            signal_reg <= key_state; // �������״̬
    end else begin
        // �������״̬�ı䣬���ü�����������ȥ�����״̬
        count <= 0;
        key_state <= key;
    end
end

assign signal = signal_reg;

endmodule

//////////////////////////////////////////////////////////////////////////////////


module Killshake(

    );
endmodule
