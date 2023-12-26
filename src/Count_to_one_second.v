module Count_to_one_second #(parameter Count_To = 50_000_000)(
    input clk,
    output one_second
);

reg [31:0] counter;
reg one_second_r;

always @(posedge clk) begin
    if((counter < Count_To) && ~one_second_r) begin
        counter <= counter + 1;
    end
    else if((counter < Count_To) && one_second_r) begin
        one_second_r <= 0;
        counter <= counter + 1;
    end
    else begin
        counter <= 0;
        one_second_r <= 1;
    end
end

assign one_second = one_second_r;

endmodule