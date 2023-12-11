`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module Edgedetect(
    input key,      // ��ť����
    input clk,      // ʱ���ź�
    output pulse // �������
);

reg key_prev; // �洢ǰһ������״̬
reg pulse_reg; // always���д���״̬

// ��ÿ��ʱ�������ظ��°���״̬
always @(posedge clk) begin
    key_prev <= key;
    // ����⵽�����ĸ���ʱ����������
    if (key_prev & ~key) 
        pulse_reg <= 1;
    else 
        pulse_reg <= 0;
end

assign pulse = pulse_reg;

endmodule
//////////////////////////////////////////////////////////////////////////////////


module Edgedetect(

    );
endmodule
