//Write a carry-save adder.

module q170 #(
    parameter N = 8 
) (
    input [N-1:0] a,
    input [N-1:0] b,
    input c_in,
    output [N-1:0] sum,
    output c_out
);
    
    wire [N-1:0] sum_bit;
    wire [N-1:0] carry_bit;

    assign sum_bit = a ^ b ^ c_in;
    assign carry_bit = (a & b) | (b & c_in) | (c_in & a);

    assign sum = {1'b0, sum_bit};
    assign c_out = {carry_bit, 1'b0};
endmodule
