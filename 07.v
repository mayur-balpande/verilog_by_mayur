//Implement a simple FSM for a traffic light controller. 

module q7(

    input wire clk,
    input wire rst,
    output reg  RED,
    output reg GREEN,
    output reg YELLOW
);

logic [1:0] state;
logic [1:0] next_state;

parameter red = 2'b00;
parameter green = 2'b01;
parameter yellow = 2'b10;



// sychronous clk and rst
always @(posedge clk) begin
    if (rst)
    state <= red;
    else
    state <= next_state;
end

always @(*) begin
    case (state)
    red : next_state = green;
    green : next_state = yellow;
    yellow : next_state = red;
    default : next_state = red;
    endcase
end

always @(*) begin 
    case (state)
    red : begin
        RED = 1;
        GREEN = 0;
        YELLOW = 0;
    end

    green : begin
        RED = 0;
        GREEN = 1;
        YELLOW = 0;
    end

yellow : begin
    RED = 0;
    GREEN = 0;
    YELLOW = 1;
end

default : begin
    RED = 1;
    GREEN = 0;
    YELLOW  = 0;
end 
    endcase
end

endmodule



