//Implement a clock divider by 3.

module q19(
    input clk,
    input reset,
    output wire clk_div_3
);

reg q_a;
reg q_b;
reg q_c;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        q_a <= 0;
        q_b <= 0;
    end
    else begin 
        q_a <= ~q_a & ~q_b;
        q_b <= q_a;
    end
end

always @ (negedge clk or posedge reset) begin
    if (reset)
    q_c <= 0;
    else begin
        q_c <= q_b;
    end
end

    assign clk_div_3 = q_b | q_c;
endmodule
