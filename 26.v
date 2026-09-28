//Implement a parameterized LFSR for random number generation.

module q26 #(
    parameter integer WIDTH = 8,
    parameter [WIDTH-1:0] TAP_MASK = 8'b10111000,
    parameter [WIDTH-1:0] SEED = 1'b1

) (
    input clk,
    input reset,
    input enable,
    output reg [WIDTH-1:0] lfsr_out
);

wire feedback;

assign feedback = ^(lfsr_out & TAP_MASK);

always @(posedge clk) begin
    if (reset)
    lfsr_out <= SEED;
    else if (enable)
    lfsr_out <= (lfsr_out << 1) | feedback;
    
end
    
endmodule
