//Design a parameterized counter.

module q86 #( parameter N = 8,
            parameter [N-1:0] Return_Value = {N{1'b0}}
) (
    input clk,
    input rst,
    input enable,
    output reg count
);

always @(posedge clk) begin
    if (rst)
    count <= Return_Value;
else if (enable)
count <= count + 1'b1;
end

    
endmodule
