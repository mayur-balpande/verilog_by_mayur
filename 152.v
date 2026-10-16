//FSM for automatic door controller.

module q152 #(
    parameter integer HOLD_CYCLES = 100
) (
    input clk,
    input reset,
    input person_detected,
    input obstruction,
    input open_limit,
    input closed_limit,

    output reg motor_open,
    output reg motor_close,
    output reg door_open
);

    localparam integer COUNT_WIDTH =
        (HOLD_CYCLES < 1) ? 1 : $clog2(HOLD_CYCLES + 1);

    localparam [1:0] CLOSED  = 2'd0,
                     OPENING = 2'd1,
                     OPEN    = 2'd2,
                     CLOSING = 2'd3;

    reg [1:0] state;
    reg [1:0] next_state;
    reg [COUNT_WIDTH-1:0] hold_count;

    always @(posedge clk) begin
        if (reset) begin
            state      <= CLOSED;
            hold_count <= {COUNT_WIDTH{1'b0}};
        end else begin
            state <= next_state;

            if (state != OPEN)
                hold_count <= {COUNT_WIDTH{1'b0}};
            else if (person_detected)
                hold_count <= {COUNT_WIDTH{1'b0}};
            else if (hold_count < HOLD_CYCLES)
                hold_count <= hold_count + 1'b1;
        end
    end

    always @(*) begin
        next_state = state;
        motor_open = 1'b0;
        motor_close = 1'b0;
        door_open = 1'b0;

        case (state)
            CLOSED: begin
                if (person_detected)
                    next_state = OPENING;
            end

            OPENING: begin
                motor_open = !open_limit;
                if (open_limit)
                    next_state = OPEN;
            end

            OPEN: begin
                door_open = 1'b1;
                if (!person_detected && (hold_count >= HOLD_CYCLES))
                    next_state = CLOSING;
            end

            CLOSING: begin
                if (obstruction || person_detected) begin
                    next_state = OPENING;
                end else if (closed_limit) begin
                    next_state = CLOSED;
                end else begin
                    motor_close = 1'b1;
                end
            end

            default: begin
                next_state = CLOSED;
            end
        endcase
    end

endmodule
