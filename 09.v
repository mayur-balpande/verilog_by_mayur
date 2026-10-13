//Write a sequence detector for the pattern "101".

module q9(
  input wire clk,
  input wire rst,
  input wire serial_in,
  output reg detected);

  reg [1:0] state;
  reg [1:0] next_state;

  parameter S0 = 2'b00;
  parameter S1 = 2'b01;
  parameter S10 = 2'b10;

  always @(posedge clk) begin
    if(rst)
      state <= S0;
    else
      state <= next_state;
  end

  always @(*) begin
    case(state)
      S0: begin
        if(serial_in)
          next_state = S1;
        else
          next_state = S0;
      end

      S1: begin
        if(serial_in)
          next_state = S1;
        else
          next_state = S10;
      end

      S10: begin
        if(serial_in)
          next_state = S1;
        else
          next_state = S0;
      end

      default: next_state = S0;
    endcase
  end

  always @(*) begin
    case(state)
      S10: begin
        if(serial_in)
          detected = 1;
        else
          detected = 0;
      end

      default: detected = 0;
    endcase
  end

endmodule
