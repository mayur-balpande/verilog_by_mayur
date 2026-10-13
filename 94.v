//  Write a testbench for FSM.


//design of vending machine from que 73


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



//testbench for vending machine
`timescale 1ns/1ps

module tb_q73;
    reg clk;
    reg reset;
    reg coin_valid;
    reg [1:0] coin;
    wire dispense;
    wire [5:0] change;

    q73 dut (
        .clk(clk),
        .reset(reset),
        .coin_valid(coin_valid),
        .coin(coin),
        .dispense(dispense),
        .change(change)
    );

    initial clk = 1'b0;
    always #5 clk = ~clk;

    task send_coin;
        input [1:0] coin_code;
        input expected_dispense;
        input [5:0] expected_change;
        begin
            @(negedge clk);
            coin       = coin_code;
            coin_valid = 1'b1;

            @(posedge clk);
            #1;
            if ((dispense !== expected_dispense) ||
                (change !== expected_change)) begin
                $display("FAIL: coin=%b dispense=%b change=%0d",
                         coin_code, dispense, change);
                $finish;
            end

            @(negedge clk);
            coin_valid = 1'b0;

            @(posedge clk);
            #1;
            if (dispense !== 1'b0 || change !== 6'd0) begin
                $display("FAIL: dispense/change did not clear");
                $finish;
            end
        end
    endtask

    task apply_reset;
        begin
            @(negedge clk);
            reset = 1'b1;
            coin_valid = 1'b0;
            repeat (2) @(negedge clk);
            reset = 1'b0;
        end
    endtask

    initial begin
        reset = 1'b1;
        coin_valid = 1'b0;
        coin = 2'b00;

        repeat (2) @(negedge clk);
        reset = 1'b0;

        // 20 + 20 + 10 = 50
        send_coin(2'b10, 1'b0, 6'd0);
        send_coin(2'b10, 1'b0, 6'd0);
        send_coin(2'b01, 1'b1, 6'd0);

        apply_reset();

        // 20 + 20 + 20 = 60, so change is 10
        send_coin(2'b10, 1'b0, 6'd0);
        send_coin(2'b10, 1'b0, 6'd0);
        send_coin(2'b10, 1'b1, 6'd10);

        apply_reset();

        // A 50-unit coin dispenses immediately
        send_coin(2'b11, 1'b1, 6'd0);

        $display("PASS");
        $finish;
    end

endmodule