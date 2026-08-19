 //Implement a simple ALU (ADD, SUB, AND, OR, XOR, Shift(Right & left)). 
 
 module q14 #(parameter N = 8)
(
    input [N-1:0] a,
    input [N-1:0] b,
    input [2:0] op,
    output reg [N-1:0] result
);

parameter ADD = 3'b000;
parameter SUB = 3'b001;
parameter AND = 3'b010;
parameter OR = 3'b011;
parameter XOR = 3'b100;
parameter SHIFT_LEFT = 3'b101;
parameter SHIFT_RIGHT = 3'b110;


always @(*) begin
    case (op)
    ADD: result = a + b;
    SUB: result = a - b;
    AND: result = a & b;
    OR: result = a | b;
    XOR: result = a ^ b;
    SHIFT_RIGHT: result = a >> b;
    SHIFT_LEFT: result = a << b;
    endcase
end
endmodule
