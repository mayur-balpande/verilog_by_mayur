//Write a glitch-free multiplexer.

module q107(
    input clk_1,
    input clk_2,
    input select,
    input reset_n,
    output reg clk_out
);

reg clk_1_enable;
reg clk_2_enable;

always @(negedge clk_1 or negedge reset_n) begin
    if (!reset_n) begin
    clk_1_enable <= 1'b0;    
    end
    else begin
       clk_1_enable <= ~select & ~clk_2_enable;
       end
end


always @(negedge clk_2 or negedge reset_n) begin
    if (!reset_n)
    clk_2_enable <= 1'b0;
    else 
    clk_2_enable <= select & ~clk_1_enable;
end

assign clk_out = (clk_1 & clk_1_enable) | (clk_2 & clk_2_enable);

endmodule
