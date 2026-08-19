// Implement a 4x1 multiplexer using `case` statement. 

module q11(

    input wire a,
    input wire b,
    input wire c,
    input wire d,
    input wire [1:0] sel,
    output reg y
);

always @(*) begin 
    case (sel)
    2'b00 : y = a;
    2'b01 : y = b;
    2'b10 : y = c;
    2'b11 : y = d;
    default : y = 1'b0;
    endcase
end
endmodule
