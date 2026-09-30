// Create a BCD to Binary converter.

module q156(
    input [7:0] bcd_in,
    input [6:0] binary_out,
    output valid
);

wire [6:0] tens;
wire [6:0] units;

assign valid = (bcd_in[7:4] <= 4'd9) && (bcd_in[3:0] <= 4'd9);

assign tens = {3'b000, bcd_in[7:4]};
assign units = {3'b000, bcd_in[3:4]};

assign binary_out = valid ? ((tens * 7'd10) + units) : 7'd0;

endmodule
