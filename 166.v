//Design a shift register with variable length using parameterization

module q166 #(parameter N = 8)(
    input clk,
    input reset_n,
    input [N-1:0] serial_in,
    output reg [N-1:0] serial_out

);

reg [N-1:0] shift_register;
always @(posedge clk or negedge reset_n) begin
    if (!reset_n)
    shift_register <= {N{1'b0}};
    else
    shift_register <= {shift_register[N-1:0], serial_in};
end
endmodule