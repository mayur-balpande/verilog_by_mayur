 //Write a 4-to-1 multiplexer. 

module q53 #( parameter WIDTH = 8)(
    input [WIDTH-1:0] a0,
    input [WIDTH-1:0] a1,
    input [WIDTH-1:0] a2,
    input [WIDTH-1:0] a3,
    input sel,
    output reg [1:0]y
    );

    always @(*) begin
        case(sel)
            2'b00: y = a0;
            2'b01: y = a1;
            2'b10: y = a2;
            2'b11: y = a3;
            default: y = 2'b00;
        endcase
    end
endmodule