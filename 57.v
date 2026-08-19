//Code a 1-bit comparator.

module q57(
    input a,
    input b,
    output a_greater,
    output a_equal,
    output a_less
);

assign a_greater = a > b;
assign a_equal = a == b;
assign a_less = a < b;
endmodule
