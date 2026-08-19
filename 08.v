//Design an 8-bit shift register (serial-in, serial-out). 
module q8(
  input wire clk,
  input wire rst,
  input wire serial_in,
  output reg serial_out);

  reg [7:0] shift_register;

  always @(posedge clk) begin
    if(rst)
      shift_register <= 8'b00000000;
    else
      shift_register <= {shift_register[6:0], serial_in};
  end

  assign serial_out = shift_register[7];
endmodule
