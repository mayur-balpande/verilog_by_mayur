//Write logic to detect rising and falling edge simultaneously.


module q160 ( 
    input  wire clk,
    input  wire reset_n,
    input  wire signal_in,
    output reg  rising_pulse,
    output reg  falling_pulse
);

    reg signal_d;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            signal_d      <= 1'b0;
            rising_pulse  <= 1'b0;
            falling_pulse <= 1'b0;
        end else begin
            signal_d      <= signal_in;
            rising_pulse  <=  signal_in & ~signal_d;
            falling_pulse <= ~signal_in &  signal_d;
        end
    end

endmodule
