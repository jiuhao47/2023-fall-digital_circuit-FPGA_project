//FIFO 吴尚哲
//时序逻辑设计B.pdf P52
//深度为L，可以先按照PPT的写，要求不穿透（非0最小延时）
module FIFO #(parameter dw=8, L=7)
( input clk, rstn,
input [dw-1:0] d_in, input req_in, output ack_in,
output [dw-1:0] d_out, output req_out, input ack_out);
reg [dw-1:0] data [L-1:0];
reg [L-1:0] valid;
reg [L-1:0] wp, rp;
assign d_out = data[rp];
assign req_out = valid[rp];
assign ack_in = ~valid[wp];
always @(posedge clk or negedge rstn)
if(~rstn) begin
wp <= 0; rp <= 0; valid <= 0;
end else begin
if(req_in & ack_in) begin
wp <= wp == L-1 ? 0 : wp + 1;
valid[wp] <= 1'b1;
data[wp] <= d_in;
end
if(req_out & ack_out) begin
rp <= rp == L-1 ? 0 : rp + 1;
valid[rp] <= 1'b0;
end
end
endmodule
