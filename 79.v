// Code for a frequency divider by 2, 4, 10

module q79(
    input clk,
    input reset_n,
    output reg clk_out_2,
    output reg clk_out_4
    outpur reg clk_out_10
);

reg [2:0] count_10;


always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        clk_out_2 <= 1'b0;
        clk_out_4 <= 1'b0;
    end
    else begin
        clk_out_2 <= ~clk_out_2;
        if (clk_out_2) begin
            clk_div_4 <= ~clk_out_4;
        end
    end
end

always @(posedge clk or negedge reset_n) begin
    if(!reset_n) begin
        count_10 <= 3'd0;
        clk_out_10 <= 1'b0;
    end
    else begin
        if (count_10 == 3'd4) begin
            clk_out_10 <= ~clk_out_10;
            count_10 <= 3'd0;
        end
        else begin
            count_10 <= count_10 + 3'd1;
        end
    end
end
endmodule
