//Design a delay line using shift registers.

module q121 #(
    parameter integer DATA_WIDTH   = 8,
    parameter integer DELAY_CYCLES = 4
) (
    input clk,
    input reset,
    input [DATA_WIDTH-1:0] data_in,
    output [DATA_WIDTH-1:0] data_out
);

    reg [DATA_WIDTH-1:0] shift_reg [0:DELAY_CYCLES-1];
    integer i;

    always @(posedge clk) begin
        if (reset) begin
            for (i = 0; i < DELAY_CYCLES; i = i + 1)
                shift_reg[i] <= {DATA_WIDTH{1'b0}};
        end else begin
            shift_reg[0] <= data_in;

            for (i = 1; i < DELAY_CYCLES; i = i + 1)
                shift_reg[i] <= shift_reg[i-1];
        end
    end

    assign data_out = shift_reg[DELAY_CYCLES-1];

endmodule
