// Implement I2C protocol FSM

module q91(
    input clk,
    input reset_n,
    input start,
    input [7:0] data_in,
    input [2:0] addr,
    input rw, //0--> write, 1--> read
    input sda,
    input scl,
    output reg [7:0] data_out,
    output reg nack,
    output reg slave_error
);
localparam IDLE = 3'b000;
localparam START = 3'b001;
localparam ADDR = 3'b010;
localparam DATA = 3'b011;
localparam STOP = 3'b100;










endmodule