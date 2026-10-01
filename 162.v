//Write a pulse stretcher module.

module q162 #(
    parameter integer STRETCH_CYCLES = 4,
    parameter integer COUNT_WIDTH =
        (STRETCH_CYCLES <= 1) ? 1 : $clog2(STRETCH_CYCLES)
) (
    input  wire clk,
    input  wire reset,
    input  wire pulse_in,
    output reg  pulse_out
);

    reg [COUNT_WIDTH-1:0] count;

    always @(posedge clk) begin
        if (reset) begin
            count     <= {COUNT_WIDTH{1'b0}};
            pulse_out <= 1'b0;
        end else if (pulse_in) begin
            count     <= STRETCH_CYCLES - 1;
            pulse_out <= 1'b1;
        end else if (count != 0) begin
            count     <= count - 1'b1;
            pulse_out <= 1'b1;
        end else begin
            pulse_out <= 1'b0;
        end
    end

endmodule
