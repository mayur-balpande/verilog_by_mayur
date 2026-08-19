//Write a parameterized N-bit subtractor. 

module q13 #(parameter N = 8)(
input wire [N-1:0] a,
input wire [N-1:0] b,
input wire bin,
output wire [N-1:0] diff,
output wire bout
);

wire [N:0] result;

assign result = {1'b0,a} - {1'b1,b} - bin;
assign diff = result [N-1:0];
assign bout = result[N];`
endmodule