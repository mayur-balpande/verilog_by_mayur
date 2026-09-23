//Design FSM for elevator control.

module q72 (
    input  wire       clk,
    input  wire       rst,

    input  wire [3:0] request,        // request[i] = request for floor i
    input  wire       door_timer_done,

    output reg  [1:0] current_floor,
    output reg        motor_up,
    output reg        motor_down,
    output reg        door_open
);

    localparam IDLE       = 3'd0;
    localparam MOVE_UP    = 3'd1;
    localparam MOVE_DOWN  = 3'd2;
    localparam DOOR_OPEN  = 3'd3;
    localparam DOOR_WAIT  = 3'd4;
    localparam DOOR_CLOSE = 3'd5;

    reg [2:0] state, next_state;

    wire request_here;
    wire request_above;
    wire request_below;

    assign request_here  = request[current_floor];

    assign request_above =
        (current_floor == 2'd0 && |request[3:1]) ||
        (current_floor == 2'd1 && |request[3:2]) ||
        (current_floor == 2'd2 &&  request[3]);

    assign request_below =
        (current_floor == 2'd3 && |request[2:0]) ||
        (current_floor == 2'd2 && |request[1:0]) ||
        (current_floor == 2'd1 &&  request[0]);

    always @(posedge clk) begin
        if (rst) begin
            state <= IDLE;
            current_floor <= 2'd0;
        end else begin
            state <= next_state;

            if (state == MOVE_UP)
                current_floor <= current_floor + 1'b1;
            else if (state == MOVE_DOWN)
                current_floor <= current_floor - 1'b1;
        end
    end

    always @(*) begin
        next_state = state;

        case (state)
            IDLE: begin
                if (request_here)
                    next_state = DOOR_OPEN;
                else if (request_above)
                    next_state = MOVE_UP;
                else if (request_below)
                    next_state = MOVE_DOWN;
            end

            MOVE_UP: begin
                if (request[current_floor + 1'b1])
                    next_state = DOOR_OPEN;
                else if (request_above)
                    next_state = MOVE_UP;
                else
                    next_state = IDLE;
            end

            MOVE_DOWN: begin
                if (request[current_floor - 1'b1])
                    next_state = DOOR_OPEN;
                else if (request_below)
                    next_state = MOVE_DOWN;
                else
                    next_state = IDLE;
            end

            DOOR_OPEN: begin
                next_state = DOOR_WAIT;
            end

            DOOR_WAIT: begin
                if (door_timer_done)
                    next_state = DOOR_CLOSE;
            end

            DOOR_CLOSE: begin
                if (request_above)
                    next_state = MOVE_UP;
                else if (request_below)
                    next_state = MOVE_DOWN;
                else if (request_here)
                    next_state = DOOR_OPEN;
                else
                    next_state = IDLE;
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end

    always @(*) begin
        motor_up   = 1'b0;
        motor_down = 1'b0;
        door_open  = 1'b0;

        case (state)
            MOVE_UP: begin
                motor_up = 1'b1;
            end

            MOVE_DOWN: begin
                motor_down = 1'b1;
            end

            DOOR_OPEN,
            DOOR_WAIT: begin
                door_open = 1'b1;
            end
        endcase
    end

endmodule
