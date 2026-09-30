//Design a binary to Excess-3 converter.

module q155(
    input bcd_in,
    output excess3_out,
    output valid
);

assign valid = (bcd_in <= 4'd9);
assign excess3_out = valid ? (bcd_in + 4'd3) : 4'b0000;

endmodule
