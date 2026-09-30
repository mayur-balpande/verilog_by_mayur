//Implement 7-segment display driver for BCD input.

module q157 #(
    parameter COMMON_ANODE = 1'b0
) (
    input  wire [3:0] bcd_in,
    output wire [6:0] seg
);

    reg [6:0] segments_on;

    always @(*) begin
        case (bcd_in)
            4'd0:    segments_on = 7'b1111110;
            4'd1:    segments_on = 7'b0110000;
            4'd2:    segments_on = 7'b1101101;
            4'd3:    segments_on = 7'b1111001;
            4'd4:    segments_on = 7'b0110011;
            4'd5:    segments_on = 7'b1011011;
            4'd6:    segments_on = 7'b1011111;
            4'd7:    segments_on = 7'b1110000;
            4'd8:    segments_on = 7'b1111111;
            4'd9:    segments_on = 7'b1111011;
            default: segments_on = 7'b0000000;
        endcase
    end

    assign seg = COMMON_ANODE ? ~segments_on : segments_on;

endmodule
