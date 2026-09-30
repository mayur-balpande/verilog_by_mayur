//Build a parameterized ALU with flags

module q111 #(parameter N = 8)(
    input [N-1:0] a,
    input [N-1:0] b,
    input [2:0]opcode,
    output reg [N-1:0] result,
    output reg zero,
    output reg negative,
    output reg carry,
    output reg overflow
);

localparam [2:0] OP_ADD = 3'b000;
localparam [2:0] OP_SUB = 3'b001;
localparam [2:0] OP_AND = 3'b010; 
localparam [2:0] OP_OR = 3'b011;
localparam [2:0] OP_XOR = 3'b100;
localparam [2:0] OP_NOT = 3'b101;

reg [N:0] temp;

always @(*) begin
    result = {N{1'b0}};
    temp = {N+1{1'b0}};
    carry = 1'b0;
    overflow = 1'b0;

    case (opcode)
    OP_ADD: begin
    temp = {1'b0, a} + {1'b0,b};
    result = temp[N-1:0];
    carry = temp[N];
    overflow = ~(a[N-1] ^ b[N-1]) & (result[N-1] ^ a[N-1]);
    end
    OP_SUB: begin
        temp     = {1'b0, a} - {1'b0, b};
        result   = temp[N-1:0];
        carry    = (a >= b); // 1 means no borrow
        overflow = (a[N-1] ^ b[N-1]) & (result[N-1] ^ a[N-1]);
    end
    OP_AND: result = a & b;
    OP_OR: result = a | b;
    OP_XOR: result = a ^ b;
    OP_NOT: result = ~a;

    default: result = {N{1'b0}};
    endcase

    zero = (result == {N{1'b0}});
    negative = result[N-1];
    
end
endmodule
