// Code a ring counter

module q99#(parameter WIDTH = 8)(
    input clk,
    input reset_n,
    input enable,
    output reg [WIDTH-1:0] q
);

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      q <= {{(WIDTH-1){1'b1}}, 1'b1};
    end
    else if (enable) begin
        q  <= {q[WIDTH-2:0], q[WIDTH-1]};
    end
end
endmoduleA
