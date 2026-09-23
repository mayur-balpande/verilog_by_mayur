//Create FSM for vending machine

module q73(
    input clk,
    input reset,
    input coin_valid,
    input [1:0] coin, // 05= 00, 10=01, 20=10, 50=11
    output reg dispense,
    output reg [5:0] change
);


    localparam S0 = 2'd0;
    localparam S1 = 2'd1;
    localparam S2 = 2'd2;
    localparam S3 = 2'd3;

    reg [1:0] state, next_state;
    reg[3:0] coin_units;
    reg [3:0] total_units;

always @(*) begin
    case (coin)
    2'b00: coin_units = 4'd5;
    2'b01: coin_units = 4'd10;
    2'b10: coin_units = 4'd20;
    2'b11: coin_units = 4'd50;
    default: coin_units = 4'd0;
    endcase
end
always @(*) begin
    next_state = state;
    dispense = 1'b0;
    change = 6'd0;
    if (coin_valid) begin
        total_units = total_units + coin_units;
        if (total_units >= 4'd50) begin
            dispense = 1'b1;
            change = total_units - 4'd50;
            next_state = S0;
            total_units = 4'd0; // Reset total units after dispensing
        end else begin
            next_state = state; // Stay in the current state until enough coins are inserted
        end
    end
end

always @(posedge clk) begin
    if (reset) begin
        state <= S0;
        total_units <= 4'd0;
    end else begin
        state <= next_state;
    end
end
endmodule
