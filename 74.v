//Create a ROM using case statement.

module q74(
    input [3:0] addr,
    output reg [7:0] data
);

always @(*) begin
    case (addr)
    4'd0: data = 8'h00;
    4'd1: data = 8'h11;
    4'd2: data = 8'h22;
    4'd3: data = 8'h33;
    4'd4: data = 8'h44;
    4'd5: data = 8'h55;
    4'd6: data = 8'h66;
    4'd7: data = 8'h77;
    4'd8: data = 8'h88;
    4'd9: data = 8'h99;
    4'd10: data = 8'hAA;
    4'd11: data = 8'hBB;
    4'd12: data = 8'hCC;
    4'd13: data = 8'hDD;
    4'd14: data = 8'hEE;
    4'd15: data = 8'hFF;
    default: data = 8'h00;
    endcase
end
endmodule
