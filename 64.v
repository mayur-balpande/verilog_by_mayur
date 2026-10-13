//Design a binary to Gray code converter. 

module q64 # (parameter N = 4)(
    input [N-1:0] binary_in,
    output [N-1:0] gray_code
);

assign gray_code = (binary_in ^ (binary_in >> 1));
endmodule
