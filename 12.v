// Design a 4-bit carry look-ahead adder. 

module q12(
    input wire [3:0] a,
    input wire [3:0]b,
    input wire cin,
    output wire [3:0]sum,
    output wire cout

);
/*logic for full adder

sum equation
assign sum = a ^ b ^ cin;

carry equation
assign cout = (a & b) | (b & cin) | (a & cin);
*/

wire c1;
wire c2;
wire c3;
wire c4;
wire [3:0] p;
wire [3:0] g;


assign p = a ^ b;  // propagtion 
assign g = a & b; // generation


//carry equations for carry look ahead adder


assign c1 = g[0] | (p[0] & cin);
assign c2 = g[1] | (p[1] & g[0]) | (p[1] & p[0] & cin);
assign c3 = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & cin);
assign c4 = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & p[0] & cin);


//sum equations fro carry look ahead adder


assign sum[0] = p[0] ^ cin;
assign sum[1] = p[1] ^ c1;
assign sum[2] = p[2] ^ c2;
assign sum[3] = p[3] ^ c3;
assign cout = c4;

endmodule

