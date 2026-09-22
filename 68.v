//Write a dual-edge triggered flip-flop.


module q68(
    input clk,
    input reset,
    input d,
    output reg q
);

always @(posedge clk or negedge clk) begin
    if (reset)
        q <= 1'b0;
        else
        q <= d;
    end
endmodule
