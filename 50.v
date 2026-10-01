//Write code for a D flip-flop with asynchronous reset

module q50(
    input clk,
    input reset_n,
    input d,
    output reg q
);

always @(posedge clk or negedge reset_n) begin

    if(!reset_n)
    q <= 1'b0;
    else 
    q <= d;
end

endmodule
