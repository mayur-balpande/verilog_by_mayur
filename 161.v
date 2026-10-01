//Create glitch-free edge detection logic.

module q161 #(
    parameter integer FILTER_CYCLES = 4,
    parameter integer COUNT_WIDTH =
        (FILTER_CYCLES <= 1) ? 1 : $clog2(FILTER_CYCLES)
) (
    input  wire clk,
    input  wire reset_n,
    input  wire async_in,
    output reg  rising_pulse,
    output reg  falling_pulse
);

    (* ASYNC_REG = "TRUE" *) reg sync_ff1;
    (* ASYNC_REG = "TRUE" *) reg sync_ff2;

    reg filtered_level;
    reg filtered_level_d;
    reg [COUNT_WIDTH-1:0] stable_count;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            sync_ff1        <= 1'b0;
            sync_ff2        <= 1'b0;
            filtered_level  <= 1'b0;
            filtered_level_d <= 1'b0;
            stable_count    <= {COUNT_WIDTH{1'b0}};
            rising_pulse    <= 1'b0;
            falling_pulse   <= 1'b0;
        end else begin
            sync_ff1 <= async_in;
            sync_ff2 <= sync_ff1;

            // Detect transitions on the filtered signal.
            rising_pulse     <=  filtered_level & ~filtered_level_d;
            falling_pulse    <= ~filtered_level &  filtered_level_d;
            filtered_level_d <= filtered_level;

            if (sync_ff2 == filtered_level) begin
                stable_count <= {COUNT_WIDTH{1'b0}};
            end else if (stable_count == FILTER_CYCLES - 1) begin
                filtered_level <= sync_ff2;
                stable_count   <= {COUNT_WIDTH{1'b0}};
            end else begin
                stable_count <= stable_count + 1'b1;
            end
        end
    end

endmodule
