//Create a timeout check for FSM lock-up.

module q143 #(
    parameter integer STATE_WIDTH   = 3,
    parameter integer TIMEOUT_CYCLES = 16
) (
    input   clk,
    input  reset,
    input  monitor_enable,
    input  clear,
    input  fsm_state,
    output reg timeout_error
);

    localparam integer COUNT_WIDTH =
        (TIMEOUT_CYCLES <= 1) ? 1 : $clog2(TIMEOUT_CYCLES);

    reg [STATE_WIDTH-1:0] previous_state;
    reg [COUNT_WIDTH-1:0] cycle_count;

    always @(posedge clk) begin
        if (reset) begin
            previous_state <= fsm_state;
            cycle_count    <= {COUNT_WIDTH{1'b0}};
            timeout_error  <= 1'b0;
        end else if (clear) begin
            previous_state <= fsm_state;
            cycle_count    <= {COUNT_WIDTH{1'b0}};
            timeout_error  <= 1'b0;
        end else if (!monitor_enable) begin
            previous_state <= fsm_state;
            cycle_count    <= {COUNT_WIDTH{1'b0}};
        end else if (fsm_state != previous_state) begin
            previous_state <= fsm_state;
            cycle_count    <= {COUNT_WIDTH{1'b0}};
        end else if (!timeout_error) begin
            if (cycle_count == TIMEOUT_CYCLES - 1)
                timeout_error <= 1'b1;
            else
                cycle_count <= cycle_count + 1'b1;
        end
    end

endmodule
