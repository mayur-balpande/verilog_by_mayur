 // Design a binary-to-BCD converter. 

module  q17(
    input [7:0] binary,
    output reg [3:0] hundreds,
    output reg [3:0] tens,
    output reg [3:0] ones
);

integer i;
reg [19:0]shift_reg;

always @(*) begin
    shift_reg = 20'b0;
    shift_reg[7:0] = binary;

    for (i=0; i<8; i=i+1) begin
        shift_reg = shift_reg << 1;
        if (shift_reg[19:16] >= 5)
            shift_reg[19:16] = shift_reg[19:16] + 3;
        if (shift_reg[15:12] >= 5)
            shift_reg[15:12] = shift_reg[15:12] + 3;
        if (shift_reg[11:8] >= 5)
            shift_reg[11:8] = shift_reg[11:8] + 3;
    end
    hundreds = shift_reg[19:16];
    tens = shift_reg[15:12];
    ones = shift_reg[11:8];
end

endmodule