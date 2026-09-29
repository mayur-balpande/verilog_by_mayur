//Write Verilog code for an N-bit adder using generate statement.

module q124 #(parameter N = 8 )(
    input [N-1:0] a,
    input [N-1:0] b,
    input cin,
    output reg [N-1:0] sum,
    output reg cout
);

//full adder logic
//assign Sum = a ^ b ^ cin;
//assign cout = (a & b) | (a & cin) | (cin & b);

wire [N:0] carry;
genvar i;

assign carry[0] = cin;
assign cout = carry[N];

generate;
    for (i = 0; i < N; i = i+1) begin : adder_bit
    assign sum[i] = a[i] ^ b[i] ^ carry[i];
    assign carry[i+1] = (a[i] & b[i]) | ((a[i] ^ b[i]) & carry[i]);
    end

endgenerate


endmodule
