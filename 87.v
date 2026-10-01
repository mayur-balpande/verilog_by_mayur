// Implement edge detector.

module q87(
    input clk,
    input reset,
    input signal_in,
    output reg falling_pulse,
    output reg rising_pulse
);

reg signal_d;
    
always @(posedge clk or negedge reset) begin
    if (reset) begin
    signal_d <= 1'b0;
    falling_pulse <= 1'b0;
    rising_pulse <= 1'b0;
    end
    else begin
        signal_d <= signal_in;
        rising_pulse <= signal_in & ~signal_d;
        falling_pulse <= ~signal_in & signal_d;
    end
end

endmodule
