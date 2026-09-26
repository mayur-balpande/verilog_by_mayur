//Design a Johnson counter

module q100 #(parameter WIDTH = 4)(
    input clk,
    input reset,
    output reg [WIDTH-1:0] count
);

always @(posedge clk or posedge reset) begin
    if (reset)
        count <= {WIDTH{1'b0}};
        else
        count <= {count[WIDTH-2:0], ~count[WIDTH-1]};
end
endmodule
