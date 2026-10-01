//Code for negative edge detector.

module q159(
    input clk,
    input reset_n,
    input signal_in,
    output reg pulse
);

reg signal_d;

always @(posedge clk or negedge reset_n) begin
    if(reset_n) begin
        signal_d <= 1'b0;
        pulse <= 1'b0; 
    end
    else begin
        signal_d <= signal_in;
        pulse <= ~signal_in & signal_d;
    end
    
end
    
endmodule
