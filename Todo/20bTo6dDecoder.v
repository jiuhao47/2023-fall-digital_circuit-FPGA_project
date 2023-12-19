//20位二进制数拆分为个、十、百、千、万、十万位的编码器
//暂时安排给吴尚哲同学
//输入：20位二进制数
//输出：[6*4-1:0] 宽度为24的信号，排列顺序为：24-1 十万----个 0
//注意：每四位为一个十进制数
//示例输入：123456的二进制码
//示例输出：0001_0010_0011_0100_0101_0110
module binary_20b_to_bcd_6d #(parameter N = 20,parameter M = 24) 
(    
	input [N-1:0] input_20b,       
	output [M-1:0] output_6d       
);  
	reg [3:0] digits [0:M-1];       

integer i;    
   initial begin     
	   for (i = 0; i < 6; i = i+1) begin
		   digits[i] = 4'd0;  
     end 
	   for(i = N-1; i >= 0; i = i-1) begin  //加3移位法 
		   if (digits[0] >= 4'b0101) digits[0] = digits[0] + 4'b0011;   
		   if (digits[1] >= 4'b0101) digits[1] = digits[1] + 4'b0011;   
		   if (digits[2] >= 4'b0101) digits[2] = digits[2] + 4'b0011;   
		   if (digits[3] >= 4'b0101) digits[3] = digits[3] + 4'b0011;     
		   if (digits[4] >= 4'b0101) digits[4] = digits[4] + 4'b0011;    
		   if (digits[5] >= 4'b0101) digits[5] = digits[5] + 4'b0011;    

		   digits[5][3:0] = {digits[5][2:0], digits[4][3]};  
		   digits[4][3:0] = {digits[4][2:0], digits[3][3]};  
		   digits[3][3:0] = {digits[3][2:0], digits[2][3]};    
		   digits[2][3:0] = {digits[2][2:0], digits[1][3]};  
		   digits[1][3:0] = {digits[1][2:0], digits[0][3]};   
		   digits[0][3:0] = {digits[0][2:0], input_20b[i]};   
	end  
end	    
	assign output_6d = digits;   
endmodule 

