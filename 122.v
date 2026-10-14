//Create an FSM with parameterized state encoding.


module q122 #(

    parameter integer STATE_WIDTH = 2,
    parameter [STATE_WIDTH-1:0] IDLE = 2'd0,
    parameter [STATE_WIDTH-1:0] WORK = 2'd1,
    parameter [STATE_WIDTH-1:0] DONE = 2'd2
)(
    input clk,
    input reset,
    input start,
    input work_done,
    output reg busy,
    output reg done
);

reg [STATE_WIDTH-1:0] state;
reg [STATE_WIDTH-1:0] next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
    end else begin
        state <= next_state;
    end
end

    always @(*) begin
        next_state = state;
        busy = 1'b0;
        done = 1'b0;

        case (state)
            IDLE: begin
                busy = 1'b0;
                done = 1'b0;
                if (start) begin
                    next_state = WORK;
                end else begin
                    next_state = IDLE;
                end
            end

            WORK: begin
                busy = 1'b1;
                done = 1'b0;
                if (work_done) begin
                    next_state = DONE;
                end else begin
                    next_state = WORK;
                end
            end

            DONE: begin
                busy = 1'b0;
                done = 1'b1;
                next_state = IDLE;
            end

            default: begin
                busy = 1'b0;
                done = 1'b0;
                next_state = IDLE;
            end
        endcase
    end
endmodule
