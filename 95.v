// 8 reg

module q95#( parameter WIDTH = 8)
    (
    input clk,
    input reset_n,
    input d,
    output reg [7:0] q
    );

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            q <= 0;
        end
        else begin
            q <= d;
        end
    end
    endmodule