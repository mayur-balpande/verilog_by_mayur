//Create FSM with multiple outputs and internal states.

module q112 (
    input  wire clk,
    input  wire reset,       // Synchronous, active-high
    input  wire start,
    input  wire fetch_done,
    input  wire execute_done,

    output reg  fetch_en,
    output reg  execute_en,
    output reg  write_en,
    output reg  busy,
    output reg  done
);

    localparam [2:0] IDLE      = 3'd0,
                     FETCH     = 3'd1,
                     EXECUTE   = 3'd2,
                     WRITEBACK = 3'd3,
                     DONE      = 3'd4;

    reg [2:0] state;
    reg [2:0] next_state;

    // State register
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next-state logic
    always @(*) begin
        next_state = state;

        case (state)
            IDLE: begin
                if (start)
                    next_state = FETCH;
            end

            FETCH: begin
                if (fetch_done)
                    next_state = EXECUTE;
            end

            EXECUTE: begin
                if (execute_done)
                    next_state = WRITEBACK;
            end

            WRITEBACK: begin
                next_state = DONE;
            end

            DONE: begin
                next_state = IDLE;
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // Moore output logic
    always @(*) begin
        fetch_en   = 1'b0;
        execute_en = 1'b0;
        write_en   = 1'b0;
        busy       = 1'b0;
        done       = 1'b0;

        case (state)
            FETCH: begin
                fetch_en = 1'b1;
                busy     = 1'b1;
            end

            EXECUTE: begin
                execute_en = 1'b1;
                busy       = 1'b1;
            end

            WRITEBACK: begin
                write_en = 1'b1;
                busy     = 1'b1;
            end

            DONE: begin
                done = 1'b1;
            end

            default: begin
                // IDLE: all outputs remain low
            end
        endcase
    end

endmodule