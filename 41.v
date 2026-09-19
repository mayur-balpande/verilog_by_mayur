//Design a Verilog module to output only odd-positioned bits from an input stream.

module q41(
    input clk,
    input reset,
    input in_data,
    output reg out_data,
    output reg out_vaild,
    input in_valid

);

reg odd_position;

always @(posedge clk) begin
    if (reset) begin
        odd_position <= 1'b1;
        out_data <= 1'b0;
        out_vaild <= 1'b0;
    end
    else begin
        out_vaild <= 1'b0;

        if (in_valid) begin
            if (odd_position) begin
                out_data <= in_data;
                out_vaild <= 1'b1;
            end
            odd_position <= ~odd_position;
        end
    end

end
endmodule
