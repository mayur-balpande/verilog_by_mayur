//Create a parallel adder using a loop.


module q163 #(
   parameter N = 8 
) (
    input [N:0] a,
    input [N:0] b,
    input cin,
    output reg [N:0] sum,
    output reg cout
);

integer i;
reg carry;

always @(*) begin

   sum   = {N{1'b0}};
        carry = cin;

        for (i = 0; i < N; i = i + 1) begin
            sum[i] = a[i] ^ b[i] ^ carry;
            carry  = (a[i] & b[i]) | ((a[i] ^ b[i]) & carry);
        end

        cout = carry;
    end

    
endmodule
