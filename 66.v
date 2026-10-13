// Create a 2-digit BCD counter. 


module q66(
    input clk,
    input reset,
    output reg [3:0] tens,
    output reg [3:0] ones
);

always @(posedge clk) begin
    if (reset) begin
        tens <= 4'b0;
        ones <= 4'b0;
    end
    else if (ones == 4'd9) begin
        ones <= 4'd0;
        if (tens == 4'd9)
        tens <= 4'd0;
    else 
    tens <=tens + 1'b1;
end
else begin
    ones <= ones + 1'b1;
end
end
endmodule

