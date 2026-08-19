// Implement a simple ALU (AND, OR, ADD, SUB).

module q62 # (parameter N = 4) (
    input [N-1:0]a,
    input [N-1:0]b,
    input [1:0] operation,
    output reg [N-1:0] result
);

localparam OP_ADD = 2'b00;
localparam OP_SUB = 2'b01;
localparam OP_AND = 2'b10;
localparam OP_OR = 2'b11;

always @(*) begin
    result = {N{1'b0}};

    case(operation)
        OP_ADD: result = a + b;
        OP_SUB: result = a - b;
        OP_AND: result = a & b;
        OP_OR:  result = a | b;
                default: result = {N{1'b0}};
    endcase
end
endmodule
