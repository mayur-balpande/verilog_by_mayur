//Create a half-adder and full-adder. 

//Half adder

module q58_half_adder(
    input a,
    input b,
    output sum,
    output carry

);

assign sum = a ^ b;
assign carry = a & b;
endmodule


//full adder

module q58_full_adder(
    input a,
    input b,
    input cin,
    output wire sum,
    output wire carry
);

assign sum = a ^ b ^ cin;
assign carry = (a & b) | (b & cin) | (a & cin);
endmodule


