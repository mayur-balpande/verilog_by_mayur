//Design a programmable counter (with variable step size).

module q174 #(parameter N = 8)(
    input clk,
    input reset_n,
    input enable,
    input [N-1:0] step,
    output reg [N-1:0] count
);

always @(posedge clk or negedge reset_n) begin
    if (!reset_n)
    count <= {N{1'b0}};
    else if (enable)
    count <= count + step;
end

endmodule