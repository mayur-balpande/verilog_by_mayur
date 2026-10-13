//Design a pipeline register with enable and reset.

module q178 #(parameter N = 8)(
    input clk,
    input reset_n,
    input enable,
    input [N-1:0] data_in,
    output reg [N-1:0] data_out
);

always @(posedge clk or negedge reset_n) begin
    if (!reset_n)
    data_out <= {N{1'b0}};
    else if (enable)
    data_out <= data_in; 
end

endmodule