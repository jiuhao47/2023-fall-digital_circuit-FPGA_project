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
	assign output_6d ={digits[5],digits[4],digits[3],digits[2],digits[1],digits[0]};   
endmodule 
  

//二进制转十进制，取反转回二进制
module binary_20b_to_bcd_6d(
	input [19:0] input_20b,
	output [23:0] output_6d
);
   reg [3:0] remainder;  
	reg [5:0] medium_6;
	reg [23:0] decoder_6d;
   reg [5:0] reverse;

   initial begin
      medium_6 = 6'b0; 
      decoder_6d = 24'b0;        

      genvar i，p;      // 从二进制转换到到十进制
      p = 1;
      generate for (i = 0; i < 20; i = i + 1) begin  
            remainder = input_20b[i]; 
            medium_6 = medium_6 + remainder * p;
            p = p * 2;
         end
      endgenerate
     
      genvar j;    // 反转medium_6                      
      generate for (j = 0; j < 6; j = j + 1) begin       
            reverse = reverse << 1;  
	      reverse[0] = medium_6[j];  
         end
      endgenerate     

      genvar k;  //十进制再转到二进制                 
      generate 
         for (k = 0; k < 6; k = k + 1) begin     
		 decoder_6d = (decoder_6d << 4) + reverse[k]; 
         end
      endgenerate 

      assign output_6d = decoder_6d;
   end
endmodule
