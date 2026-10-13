 // Implement an 8-bit ripple carry adder. 

module q16(
    input A,
    input B,
    input Cin,
    output S,
    output  Cout
);

assign S = A ^ B ^ Cin;
assign Cout = (A & B) | (B & Cin) | (A & Cin);
endmodule


module ripple_adder # (parameter N = 8)(
    input wire [N-1:0] A,
    input wire [N-1:0] B,
    input Cin,
    output [N-1:0] S,
    output Cout
);

wire C1;
wire C2;
wire C3;
wire C4;
wire C5;
wire C6;
wire C7;


q16 RA0(
    .A(A[0]),
    .B(B[0]),
    .Cin(Cin),
    .S(S[0]),
    .Cout(C1)
);

q16 RA1(
    .A(A[1]),
    .B(B[1]),
    .Cin(C1),
    .S(S[1]),
    .Cout(C2)
);

q16 RA2(
    .A(A[2]),
    .B(B[2]),
    .Cin(C2),
    .S(S[2]),
    .Cout(C3)
);

q16 RA3(
    .A(A[3]),
    .B(B[3]),
    .Cin(C3),
    .S(S[3]),
    .Cout(C4)
);

q16 RA4(
    .A(A[4]),
    .B(B[4]),
    .Cin(C4),
    .S(S[4]),
    .Cout(C5)
);

q16 RA5(
    .A(A[5]),
    .B(B[5]),
    .Cin(C5),
    .S(S[5]),
    .Cout(C6)
);

q16 RA6(
    .A(A[6]),
    .B(B[6]),
    .Cin(C6),
    .S(S[6]),
    .Cout(C7)
);

q16 RA7(
    .A(A[7]),
    .B(B[7]),
    .Cin(C7),
    .S(S[7]),
    .Cout(Cout)
);
endmodule